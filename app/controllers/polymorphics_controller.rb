module PolymorphicsController
  def get_object(relation_params, relation, values)
    raise  ActiveRecord::UnknownAttributeError unless relation_params[:klass]
    klass = relation_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? relation
    object = klass.find(relation_params[:id])
    @success = object.send(relation).create(values)
    respond_to do |format|
      if @success
        format.html { redirect_to relation_params[:path], notice: I18n.t("#{relation_params[:render_view].split('/').join('.')}.#{relation}.success", default: t("#{relation}.success")) }
      else
        format.html{ redirect_to relation_params[:path], notice: I18n.t("#{relation_params[:render_view].split('/').join('.')}.#{relation}.error", default: t("#{relation}.error")) }
      end
    end
  end

end