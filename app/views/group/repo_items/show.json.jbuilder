json.partial! 'group/repo_items/repo_item', repo_item: @repo_item
json.partial! 'group/repo_items/parent', repo_item: @repo_item
json.children @children do |json, child|
  json.partial! 'group/repo_items/repo_item', repo_item: child
end