class StatusesController < ApplicationController

  before_action :status_params

  def create
    raise  ActiveRecord::UnknownAttributeError unless status_params[:klass]
    klass = status_params[:klass].to_s.constantize
    raise ActiveRecord::UnknownAttributeError unless klass.method_defined? :statuses
    status = klass.send('statuses.new')
    status.title = status_params[:title]
    status.comment = status_params[:comment]
    status.user = current_user
    status.save
  end


  private

  def test

  end

  def status_params
    logger.debug('salut')
    params.require(:status).permit(:title, :message, :klass)
  end
end