class TopicsController < ApplicationController
  before_action :topic_params
  before_action :sign_in_user


  def create
    raise  ActiveRecord::UnknownAttributeError unless topic_params[:klass]
    klass = topic_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? 'topics'
    object = klass.find(topic_params[:id])
    if object.is_a? Group::WorkGroup and object.can_not? :write, :topic, current_user
      raise CanCan::AccessDenied
    end
    status = object.topics.create(message: topic_params[:message], writer: current_user)
    respond_to do |format|
      if status.save #&& status.create_activity(:create, owner: current_user, recipient: object)
        format.html { redirect_to topic_params[:path], notice:  notice_after('success', on: 'create')}
      else
        format.html{ redirect_to topic_params[:path], alert: notice_after('error', on: 'create') }
      end
    end
  end

  def update
    topic = Topic.find params[:id]
    respond_to do |format|
      if topic.update(message: topic_params[:message])
        format.html { redirect_to topic_params[:path], notice: notice_after('success', on: 'update') }
      else
        format.html { redirect_to topic_params[:path], alert: notice_after('error', on: 'update') }
      end
    end
  end


  private

  def notice_after(status = 'success', on: 'create')
    I18n.t("#{topic_params[:render_view].split('/').join('.')}.topic.#{on}.#{status}", default: t("topic.#{status}"))
  end

  def topic_params
    params.require(:topic).permit(:message, :klass, :id, :path, :render_view)
  end

  def p_status
    params[:p_status]
  end
end