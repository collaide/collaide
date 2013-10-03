class Notification::Register
  def self.perform(class_name, method_name, values, owners)
    find_ids(owners).each do |an_id|
       UserNotification.create(
           class_name: class_name,
           method_name: method_name,
           values: values.to_json,
           user: an_id
       )
    end
  end

  private

    def find_ids(owners)
      ids = []
      ids << owners[:user].id unless owners[:user].nil?
      unless owners[:group].nil?
        owners[:group].users.each do |a_user|
          ids << a_user.id
        end
      end
      if owners[:role_group].is_a? String
        User.where(roles: User::ROLES.index(owners[:role_group])).each do |a_user|
          ids << a_user.id
        end
      end
      unless owners[:users].nil? and owners[:users].empty?
        owners[:users].each do |a_user|
          ids << a_user.id if a_user.is_a? User
          ids << a_user if a_user.is_a? Integer
        end
      end
      unless owners[:groups].nil? and owners[:groups].empty?
        owners[:groups].each do |a_group|
          if a_group.is_a? Member::Group
            a_group.users.each do |a_user|
              ids << a_user.id
            end
          end
        end
      end
      return ids
    end
end