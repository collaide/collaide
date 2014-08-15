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

  def notify
    #TODO ajouter erreur 406 quand il y a plus de 40 notifications
    #TODO permissions -> user doit être membre du groupe
    # TDOD test it
    group = Group::WorkGroup.find(params[:group_id])
    notifications = group.notifications.find_for_api(
        params[:last_seen], params[:type]
    ).to_a
    respond_to do |format|
      if notifications.any?
        format.json { render status: 200, json: notifications.to_json }
      else
        format.json { render status: 204, text: 'no content' }
      end
    end
  end
end
