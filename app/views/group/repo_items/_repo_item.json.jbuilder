json.(repo_item, :id, :name, :file_size, :content_type)
json.is_folder repo_item.is_folder?
json.owner do |json|
  json.(repo_item.owner, :id)
  json.name repo_item.owner.to_s
  case repo_item.owner.type
    when 'Group::WorkGroup'
      json.url group_work_group_url(repo_item.owner)
  end
end
json.sender do |json|
  json.(repo_item.sender, :id)
  json.name repo_item.sender.to_s
  case repo_item.sender_type
    when 'User'
      json.url user_url(repo_item.sender)
  end
end
json.download group_work_group_repo_item_download_url(repo_item.owner, repo_item)
json.url group_work_group_repo_item_url(repo_item.owner, repo_item)
json.rename group_work_group_repo_item_rename_url(repo_item.owner, repo_item)
json.copy group_work_group_repo_item_copy_url(repo_item.owner, repo_item)
json.move group_work_group_repo_item_move_url(repo_item.owner, repo_item)