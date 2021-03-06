class CommentsController < ApplicationController
  include PolymorphicsController
  def create
    get_object(comment_params, 'comments', {comment: comment_params[:comment], title: comment_params[:title], owner: current_user}) do |object|
      object.is_a? Topic and object.owner.is_a? Group::Group and object.owner.can_not? :write, :topic, current_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:klass, :id, :path, :render_view, :comment, :title)
  end
end