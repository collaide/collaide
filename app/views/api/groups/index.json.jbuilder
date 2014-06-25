json.groups @groups do |group_member|
  json.group do
    group = group_member.group
    json.id group.id
    json.name group.name
    json.url group_work_group_url(group)
  end
end