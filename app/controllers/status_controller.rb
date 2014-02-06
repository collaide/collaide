class StatusController
  def create
    raise  ActiveRecord::UnknownAttributeError unless status_params[:klass]
    klass = status_params[:klass].to_s.constantize
    raise ActiveRecord::UnknownAttributeError unless klass.method_defined? :statuses
    status = klass.send('statuses.create')
    status.title = status_params[:title]
    status.comment = status_params[:comment]
    status.user = current_user
    status.save
  end


  private

  def status_params
    params.require(:status).permit(:title, :comment, :klass)
  end
end