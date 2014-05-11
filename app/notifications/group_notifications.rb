# -*- encoding : utf-8 -*-
class GroupNotifications < NotificationSystem::AbstractClass

  def is_invited(sender_id, group_id, receiver_id)
    #invitation = Group::Invitation.find invitation_id
    sender = User.find_by id: sender_id
    group = Group::Group.find_by id: group_id

    if (group and sender)
      raw I18n.t(
        'notifications.groups.is_invited',
        sender: link_to(h(sender.to_s), sender),
        group: link_to(h(group.name), group),
        link: link_to(I18n.t('notifications.link'), user_invitations_path(receiver_id))
    )
    else
      deleted_message
    end
  end

  def is_no_longer_invited(sender_id, group_id)
    #sender = User.find sender_id
    group = Group::Group.find_by id: group_id
    if group
      raw I18n.t(
            'notifications.groups.is_no_longer_invited',
            #sender: link_to(h(sender.to_s), sender),
            group: link_to(h(group.name), group)
        )
    else
      deleted_message
    end
  end
end
