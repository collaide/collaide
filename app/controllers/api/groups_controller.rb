class Api::GroupsController < ApplicationController
  include Concerns::PermissionConcern

  def index
    @user = User.find params[:user_id]
    check_permission { current_user.id == @user.id }
    @groups = Group::GroupMember.get_user_groups(@user).includes(:group)
    respond_to do |format|
      format.json
    end
  end
end
