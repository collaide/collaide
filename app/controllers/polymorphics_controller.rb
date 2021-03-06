module PolymorphicsController
  def get_object(relation_params, relation, values)
    raise  ActiveRecord::UnknownAttributeError unless relation_params[:klass]
    klass = relation_params[:klass].to_s.constantize
    raise  ActiveRecord::UnknownAttributeError unless klass.method_defined? relation
    object = klass.find(relation_params[:id])
    access_denied = yield object
    if block_given? and access_denied
      # Raise que si il n'est pas super_admin ou non membre
      raise CanCan::AccessDenied if (!current_user.nil? and !current_user.super_admin?) or (current_user.nil?)
    end
    @success = object.send(relation).create(values)
    respond_to do |format|
      if @success #&& @success.create_activity(:create, owner: current_user, recipient: object)
        format.html { redirect_to relation_params[:path], notice: I18n.t("#{relation_params[:render_view].split('/').join('.')}.#{relation}.success", default: t("#{relation}.success")) }
      else
        format.html{ redirect_to relation_params[:path], notice: I18n.t("#{relation_params[:render_view].split('/').join('.')}.#{relation}.error", default: t("#{relation}.error")) }
      end
    end
  end

end
