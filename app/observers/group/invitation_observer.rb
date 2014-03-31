# -*- encoding : utf-8 -*-
class Group::InvitationObserver < ActiveRecord::Observer

  # MaClasseDeNotification.perform_later(
  # :la_méthode_contenant_le_texte_de_la_notification,
  # [les_paramètres_de_la_méthode],
  # <pour qui elle doit être créée>)

  def after_create(invitation)
    #On créé une notification pour les administrateurs
    DocumentNotifications.perform_later(
        :create_for_user, #la méthode de la notif
        [invitation.id], # les paramètres de la notification
        'user' => invitation.receiver_id,# on notifie le receveur
    )
    UserNotificationsMailer.invitation_created(invitation.receiver_id).deliver # On envoi un e-mail à celui qui à recu l'invitation
  end
end
