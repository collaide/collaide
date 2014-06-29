json.groups do
  json.array! @groups do |group_member|
    group = group_member.group
    json.id group.id
    json.name group.name
    json.url group_work_group_url(group)
  end
end