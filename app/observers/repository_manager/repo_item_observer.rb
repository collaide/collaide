# -*- encoding : utf-8 -*-
class RepositoryManager::RepoItemObserver < ActiveRecord::Observer
  #observe :'RepositoryManager::RepoItem'

  def after_create(repo_item)
    if repo_item.owner.class.base_class.to_s == 'Group::Group'
      if repo_item.is_file?

        notified_member_ids = repo_item.owner.u_members.map(&:id)
        notified_member_ids.delete(repo_item.sender.id)

        #On créé une notification pour le receveur
        RepositoryManagerNotifications.perform_later(
            :create_file_in_group, #la méthode de la notif
            [repo_item.id], # les paramètres de la notification
            'users' => notified_member_ids,# on notifie les users membres du groupe (sans le sender)
        )
      end
      #UserNotificationsMailer.invitation_created(invitation.receiver_id).deliver # On envoi un e-mail à celui qui à recu l'invitation
    else
      # Todo when implemented
    end
  end

  def after_destroy(invitation)
    if invitation.receiver_type == 'User'
      #On créé une notification pour le receveur
      GroupNotifications.perform_later(
          :is_no_longer_invited,
          [invitation.sender.id, invitation.group.id], # les paramètres de la notification
          'user' => invitation.receiver_id,# on notifie le receveur
      )
    end
  end
end

