module Concerns::PermissionConcern
  def check_permission
    raise CanCan::AccessDenied if current_user.nil?
    return unless block_given?
    return if current_user.super_admin?
    raise CanCan::AccessDenied unless yield
  end
end