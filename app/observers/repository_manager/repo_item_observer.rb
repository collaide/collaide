# -*- encoding : utf-8 -*-
class RepositoryManager::RepoItemObserver < ActiveRecord::Observer
  include Concerns::ActivityConcern
  #observe :'RepositoryManager::RepoItem'

  def after_create(repo_item)
    #j'ai commenté, sinon j'ai une erreur quand on copie un élément ailleur que dans le répertopire de base
    if repo_item.owner.class.base_class.to_s == 'Group::Group'
      group = repo_item.owner
      if repo_item.is_file?
        notified_member_ids = group.u_members.map(&:id)
        notified_member_ids.delete(repo_item.sender.id)
        unless notified_member_ids.empty?
          #On créé une notification pour le receveur
          RepositoryManagerNotifications.perform_later(
              :create_file_in_group, #la méthode de la notif
              [repo_item.id], # les paramètres de la notification
              'users' => notified_member_ids, # on notifie les users membres du groupe (sans le sender)
          )
        end
      end
      #AppNotificationsMailer.invitation_created(invitation.receiver_id).deliver # On envoi un e-mail à celui qui à recu l'invitation
      create_activity(:create, trackable: repo_item, owner: repo_item.sender, recipient: repo_item.owner)
      create_api_notification(
          group,
          ApiNotification::ItemChanged,
          notifier: repo_item,
          from_path: repo_item.file.current_path
      )
    else
      # Todo when implemented
    end
  end

  def after_destroy(repo_item)
    if repo_item.owner.class.base_class.to_s == 'Group::Group'
      create_api_notification(
          repo_item.owner,
          ApiNotification::ItemDeleted,
          notifier: repo_item,
          from_path: repo_item.file.current_path
      )
      create_activity(:destroy, trackable: repo_item, owner: ObserverHelpers.current_user, recipient: repo_item.owner, params: {name: repo_item.name})
    end
  end

  private

  def create_api_notification(owner, type, options)
    owner.notifications << type.new(options)
    owner.save
  end
end

