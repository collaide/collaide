json.array! @users do |json, user|
  json.id user.id
  json.value user.to_single_name
  json.img user.avatar.mini.url
  json.name user.to_s
  json.path user_path(user)
end
