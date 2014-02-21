class Group::InvitationsController < ApplicationController
  def create
    do_invitation = Group::DoInvitation.new(group_invitation_params)
    do_invitation.group_id = params[:work_group_id]
    if do_invitation.valid?
      group = Group::Group.find params[:work_group_id]
      group.send_invitations(do_invitation)
      redirect_to group_work_group_members_path(group), notice: t('group.invitations.create.notice')
    else
      @group = Group::Group.find(params[:work_group_id])
      @invitation = do_invitation
      render 'group/work_groups/members'
    end
  end

  def destroy
    invitation = Group::Invitation.find params[:id]
    invitation.destroy
    redirect_to group_work_group_members_path, notice: t('group.invitations.destroy.notice')
  end

  private

  def group_invitation_params
    params.require(:group_do_invitation).permit({users_id: []}, :email_list, :message)
  end
end