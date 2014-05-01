module Concerns::PermissionConcern
  def check_permission
    return unless block_given?
    raise CanCan::AccessDenied if current_user.nil?
    return if current_user.super_admin?
    raise CanCan::AccessDenied unless yield
  end
end