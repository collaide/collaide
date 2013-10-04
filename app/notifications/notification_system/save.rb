class NotificationSystem::Save
  require 'yaml'
  @queue = 'user_notifications'

  def self.perform(class_name, method_name, values, owners)

    user_id = owners['user']
    users_ids = owners['users']
    user_role = owners['user_role']
    user_roles = owners['user_roles']
    json_values = values.to_json
    unless user_id.nil?
      UserNotification.create!(
          class_name: class_name,
          method_name: method_name,
          values: json_values,
          user_id: user_id
      )
      puts "User saved #{user_id}"
    end
    if users_ids.is_a?(Array)
      users_ids.each do |an_id|
        UserNotification.create!(
            class_name: class_name,
            method_name: method_name,
            values: json_values,
            user_id: an_id
        )
        puts "User saved #{an_id}"
      end
    end
    if user_role.is_a? String
      User.with_role(user_role.to_sym).each do |a_user|
        UserNotification.create!(
            class_name: class_name,
            method_name: method_name,
            values: json_values,
            user_id: a_user.id
        )
        puts "User saved #{a_user.id}"
      end
    end

    if user_roles.is_a? Array
      where_conditions = user_roles.map { |a_role| "users.role='#{a_role}'" }.join(' OR ')
      User.where(where_conditions).all.each do |a_user|
        UserNotification.create!(
            class_name: class_name,
            method_name: method_name,
            values: json_values,
            user_id: a_user.id
        )
        puts "User saved #{a_user.id}"
      end
    end
  end

  private


    def find_users(owners)
      users = []
      #unless owners['user'].nil?
        puts 'salut'
        users << User.find(owners['user'])
     # end

      #unless owners['group'].nil?
      #  group = owners['group'] if owners['group'].is_a User::Group
      #  group = User::Group.find owners['group'] if owners['group'].is_a Integer
      #  group.users.each do |a_user|
      #    users << a_user.id
      #  end
      #end
      #if owners['role_group'].is_a? String
      #  User.where(roles: User::ROLES.index(owners['role_group'])).each do |a_user|
      #    users << a_user
      #  end
      #end
      #unless owners['users'].nil? and owners['users'].empty?
      #  owners['users'].each do |a_user|
      #    users << a_user if a_user.is_a? User
      #    users << User.find(a_user) if a_user.is_a? Integer
      #  end
      #end
      #unless owners['groups'].nil? and owners['groups'].empty?
      #  owners['groups'].each do |a_group|
      #    if a_group.is_a? Member::Group
      #      a_group.users.each do |a_user|
      #        users << a_user
      #      end
      #    end
      #  end
      #end
      return users
    end
end