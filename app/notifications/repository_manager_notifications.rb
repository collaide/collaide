# -*- encoding : utf-8 -*-
class RepositoryManagerNotifications < NotificationSystem::AbstractClass

  # A repo item was created in a group
  def create_file_in_group(repo_item_id)
    repo_item = RepositoryManager::RepoItem.includes(:owner, :sender).find_by id: repo_item_id

    if repo_item
      group = repo_item.owner
      sender = repo_item.sender
      raw I18n.t(
        'notifications.repository_manager.repo_items.create_in_group',
        sender: link_to(h(sender.to_s), sender),
        group: link_to(h(group.name), group),
        file: link_to(h(repo_item.name), group_work_group_repo_item_path(group, repo_item))
    )
    else
      deleted_message
    end
  end
end
