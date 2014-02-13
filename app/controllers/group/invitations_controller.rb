class Group::InvitationsController < ApplicationController
  def create
    group = Group::Group.find params[:work_group_id]
    group.send_invitations(group_invitation_params[:users_ids], message: group_invitation_params[:message], sender: current_user)
    redirect_to group_work_group_members_path(group), notice: t('group.invitations.create.notice')
  end

  def destroy
    invitation = Group::Invitation.find params[:id]
    invitation.destroy
    redirect_to group_work_group_members_path, notice: t('group.invitations.destroy.notice')
  end

  private

  def group_invitation_params
    params.require(:group_invitation).permit({users_ids: []}, :users, :message)
  end
end