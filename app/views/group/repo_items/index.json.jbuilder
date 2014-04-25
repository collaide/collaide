json.repo_items @repo_item do |json, item|
  json.partial! 'group/repo_items/repo_item', repo_item: item
end
json.url group_work_group_repo_items_path(@group)