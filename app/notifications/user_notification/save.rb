class UserNotification::Save

  @queue = 'user_notifications'

  def self.perform(class_name, method_name, values, owners)
    find_users(owners).each do |a_user|
       UserNotification.create(
           class_name: class_name,
           method_name: method_name,
           values: values.to_json,
           user: a_user
       )
    end
  end

  private

    def find_users(owners)
      users = []
      unless owners[:user].nil?
        users << owners[:user].id if owners[:user].is_a User
        users << User.find(owners[:user]) if owners[:user].is_a Integer
      end

      unless owners[:group].nil?
        group = owners[:group] if owners[:group].is_a User::Group
        group = User::Group.find owners[:group] if owners[:group].is_a Integer
        group.users.each do |a_user|
          users << a_user.id
        end
      end
      if owners[:role_group].is_a? String
        User.where(roles: User::ROLES.index(owners[:role_group])).each do |a_user|
          users << a_user
        end
      end
      unless owners[:users].nil? and owners[:users].empty?
        owners[:users].each do |a_user|
          users << a_user if a_user.is_a? User
          users << User.find(a_user) if a_user.is_a? Integer
        end
      end
      unless owners[:groups].nil? and owners[:groups].empty?
        owners[:groups].each do |a_group|
          if a_group.is_a? Member::Group
            a_group.users.each do |a_user|
              users << a_user
            end
          end
        end
      end
      return users
    end
end