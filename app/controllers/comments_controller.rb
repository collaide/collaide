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
    object = klass.find(comment_params[:id])
    object.is_a? Topic and object.owner.is_a? Group::Group and object.owner.can_not? :write, :topic, current_user
    comment = object.comments.where(id: params[:id]).take
    if comment.update(comment: comment_params[:comment])
      redirect_to comment_params[:path], notice: t('comments.update')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:klass, :id, :path, :render_view, :comment, :title)
  end
end