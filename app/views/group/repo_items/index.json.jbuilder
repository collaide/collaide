json.repo_items @repo_item do |item|
  #json.id item.id
  #json.partial! 'group/repo_items/repo_item', repo_item: item
  json.(item, :id, :name, :file_size, :content_type)
  json.is_folder item.is_folder?
  json.md5 Digest::MD5.file(item.file.url).hexdigest unless item.is_folder?
  json.owner do
    json.(item.owner, :id)
    json.name item.owner.to_s
    case item.owner.type
      when 'Group::WorkGroup'
        json.url group_work_group_url(item.owner)
    end
  end
  json.sender do
    json.(item.sender, :id)
    json.name item.sender.to_s
    case item.sender_type
      when 'User'
        json.url user_url(item.sender)
    end
  end
  json.download api_group_repo_item_download_url(item.owner, item)
  json.url api_group_repo_item_url(@group, item)
  json.rename api_group_repo_item_rename_url(item.owner, item)
  json.copy api_group_repo_item_copy_url(item.owner, item)
  json.move api_group_repo_item_move_url(item.owner, item)
  json.share api_group_repo_item_sharings_url(item.owner, item)
  json.path do
    json.url api_group_repo_item_path(@group, item)
    json.name item.name
  end
end
json.url group_work_group_repo_items_path(@group)
