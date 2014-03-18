class StatusesController < ApplicationController

  before_action :status_params

  def create
    raise  ActiveRecord::UnknownAttributeError unless status_params[:klass]
    klass = status_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? 'statuses'
    object = klass.find(status_params[:id])
    status = object.statuses.create(message: status_params[:message], writer: current_user)
    respond_to do |format|
      if status.save && status.create_activity(:create, owner: current_user, recipient: object)
        format.html { redirect_to status_params[:path], notice:  notice_after('success', on: 'create')}
      else
        format.html{ redirect_to status_params[:path], alert: notice_after('error', on: 'create') }
      end
    end
  end

  def update
    status = Status.find params[:id]
    respond_to do |format|
      if status.update(message: status_params[:message])
        format.html { redirect_to status_params[:path], notice: notice_after('success', on: 'update') }
      else
        format.html { redirect_to status_params[:path], alert: notice_after('error', on: 'update') }
      end
    end
  end


  private

  def notice_after(status = 'success', on: 'create')
    I18n.t("#{status_params[:render_view].split('/').join('.')}.status.#{on}.#{status}", default: t("status.#{status}"))
  end

  def status_params
    params.require(:status).permit(:message, :klass, :id, :path, :render_view)
  end
end