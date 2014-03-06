json.partial! 'group/repo_items/repo_item', repo_item: @repo_item
if @repo_item.parent.nil?
  json.parent nil
else
  json.parent do |json|
    json.(@repo_item.parent, :id, :name)
    json.url group_work_group_repo_item_url(@repo_item.owner, @repo_item.parent)
  end
end
json.children @children do |json, child|
  json.partial! 'group/repo_items/repo_item', repo_item: child
end