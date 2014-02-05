class CommentsController
  def create
    raise  ActiveRecord::UnknownAttributeError unless comment_params[:klass]
    klass = comment_params[:klass].to_s.constantize
    raise ActiveRecord::UnknownAttributeError unless klass.method_defined? :comments
    comment = klass.send('comments.create')
    comment.title = comment_params[:title]
    comment.comment = comment_params[:comment]
    comment.user = current_user
    comment.save
  end


  private

  def comment_params
    params.require(:comment).permit(:title, :comment, :klass)
  end
end