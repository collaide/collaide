# -*- encoding : utf-8 -*-
class Group::InvitationObserver < ActiveRecord::Observer

  # MaClasseDeNotification.perform_later(
  # :la_méthode_contenant_le_texte_de_la_notification,
  # [les_paramètres_de_la_méthode],
  # <pour qui elle doit être créée>)

  def after_create(invitation)
    if invitation.receiver_type == 'User'
      #On créé une notification pour le receveur
      GroupNotifications.perform_later(
          :is_invited, #la méthode de la notif
          [invitation.sender.id, invitation.group.id, invitation.receiver_id], # les paramètres de la notification
          'user' => invitation.receiver_id,# on notifie le receveur
      )
      #UserNotificationsMailer.invitation_created(invitation.receiver_id).deliver # On envoi un e-mail à celui qui à recu l'invitation
    end
  end
end
