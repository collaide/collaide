# -*- encoding : utf-8 -*-
class Base
  def send (message, title='')
    Pusher['private-'+params[:message][:recipient_id]].trigger(title, {:msg => message})
  end

  def register(method, values, owners)
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
    Resque.enque(Notification::Register, self.to_s, method, values, ids)
  end
end
