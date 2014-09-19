class CommentsController < ApplicationController
  include PolymorphicsController
  def create
    get_object(comment_params, 'comments', {comment: comment_params[:comment], title: comment_params[:title], owner: current_user}) do |object|
      object.is_a? Topic and object.owner.is_a? Group::Group and object.owner.can_not? :write, :topic, current_user
    end
  end

  def update
    raise  ActiveRecord::UnknownAttributeError unless comment_params[:klass]
    klass = comment_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? 'comments'
    object = klass.find(comment_params[:id])
    if object.is_a? Group::WorkGroup and object.can_not? :write, :topic, current_user
      raise CanCan::AccessDenied
    end
    object
  end

  private

  def comment_params
    params.require(:comment).permit(:klass, :id, :path, :render_view, :comment, :title)
  end
end