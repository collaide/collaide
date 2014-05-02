class Group::EmailInvitationsController < ApplicationController
  load_and_authorize_resource class: Group::EmailInvitation
  def update
    @ei = Group::EmailInvitation.find params[:id]
    if @ei.secret_token = params[:secret_token]
      case params[:status]
        when 'later'
          @ei.status = :later
          @ei.save
          redirect_to user_path(current_user), notice: t('group.invitations.update.notice.later')
        when 'refused'
          @ei.status = :refused
          @ei.save
          redirect_to user_path(current_user), notice: t('group.invitations.update.notice.refuse')
        # par défaut l'invitation est acceptée
        else
          if @ei.status == :accepted
            redirect_to user_path(invitation.user), notice: t('group.invitations.update.notice.already_member')
          end
          @group = Group::WorkGroup.find params[:work_group_id]
          if @group.add_members current_user, joined_method: :was_invited_by_email, invited_or_added_by: @ei.user
            @ei.status = :accepted
            @ei.save
          else
            redirect_to back, alert: t('group.email_invitations.error')
            return
          end
          redirect_to group_work_group_path(@group), notice: t('group.email_invitations.member')
      end
    else
      redirect_to back, notice: t('group.email_invitations.error')
    end
  end

  def destroy
    ei = Group::EmailInvitation.find params[:id]
    ei.destroy
    redirect_to group_work_group_members_path, notice: t('group.invitations.destroy.notice')
  end
end