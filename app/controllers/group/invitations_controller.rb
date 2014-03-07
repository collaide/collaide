class Group::InvitationsController < ApplicationController
  load_and_authorize_resource class: Group::Invitation

  before_action :group_create_invitation_params, only: [:create]
  before_action :group_update_invitations_params, only: [:update]

  def create
    logger.debug'salut'
    do_invitation = Group::DoInvitation.new(group_create_invitation_params)
    do_invitation.group_id = params[:work_group_id]
    if do_invitation.valid?
      group = Group::Group.find params[:work_group_id]
      group.send_invitations(do_invitation, sender: current_user)
      redirect_to group_work_group_members_path(group), notice: t('group.invitations.create.notice')
    else
      @group = Group::Group.find(params[:work_group_id])
      @invitation = do_invitation
      render 'group/work_groups/members'
    end
  end

  def update
    invitation = Group::Invitation.find params[:id]
    if invitation.status == :accepted
      redirect_to user_path(invitation.user), notice: t('group.invitations.update.notice.already_member')
    end
    if get_status == :accepted
      group = Group::Group.find params[:work_group_id]
      group.add_members(invitation.receiver, joined_method: :was_invited, invited_or_added_by: invitation.sender)
      group.save
      invitation.status = :accepted
      invitation.save
      redirect_to group_work_group_path(group), notice: t('group.invitations.update.notice.accept')
    elsif get_status == :refused
      invitation.status = :refused
      invitation.save
      redirect_to user_path(invitation.user), notice: t('group.invitations.update.notice.refuse')
    elsif get_status == :later
      invitation.status = :later
      invitation.save
      redirect_to user_path(invitation.user), notice: t('group.invitations.update.notice.later')
    else
      redirect_to user_path(invitation.user), notice: t('group.invitations.update.notice.bordel')
    end
  end

  def destroy
    invitation = Group::Invitation.find params[:id]
    invitation.destroy
    redirect_to group_work_group_members_path, notice: t('group.invitations.destroy.notice')
  end

  private

  def get_status
    group_update_invitations_params[:status].to_sym
  end

  def group_update_invitations_params
    params.require(:group_invitation).permit(:status)
  end

  def group_create_invitation_params
    params.require(:group_do_invitation).permit({users_id: []}, :email_list, :message)
  end
end