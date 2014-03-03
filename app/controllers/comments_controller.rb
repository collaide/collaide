class CommentsController < ApplicationController
  include PolymorphicsController
  def create
    get_object(comment_params, 'comments', {comment: comment_params[:comment], title: comment_params[:title], owner: current_user})
  end

  private

  def comment_params
    params.require(:comment).permit(:klass, :id, :path, :render_view, :comment, :title)
  end
end