class StatusesController < ApplicationController

  before_action :status_params

  def create
    raise  ActiveRecord::UnknownAttributeError unless status_params[:klass]
    klass = status_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? 'statuses'
    object = klass.find(status_params[:id])
    success = object.statuses.create(message: status_params[:message], writer: current_user)
    respond_to do |format|
      if success.save
        logger.debug("#{status_params[:render_view].split('/').join('.')}.status.success")
        format.html { redirect_to status_params[:path], notice: I18n.t("#{status_params[:render_view].split('/').join('.')}.status.success", default: t('status.success')) }
      else
        format.html{ redirect_to status_params[:path], notice: I18n.t("#{status_params[:render_view].split('/').join('.')}.status.error", default: t('status.error')) }
      end
    end
  end


  private

  def status_params
    params.require(:status).permit(:message, :klass, :id, :path, :render_view)
  end
end