# -*- encoding : utf-8 -*-
class GroupNotifications < NotificationSystem::AbstractClass

  def is_invited(sender_id, group_id)
    #invitation = Group::Invitation.find invitation_id
    sender = User.find sender_id
    group = Group::Group.find group_id
    raw I18n.t(
        'notifications.groups.is_invited',
        sender: link_to(h(sender.to_s), sender),
        group: link_to(h(group.name), group)
    )
  end
end
