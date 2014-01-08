# -*- encoding : utf-8 -*-
class Advertisement::AdvertisementObserver < ActiveRecord::Observer

  # MaClasseDeNotification.perform_later(
  # :la_méthode_contenant_le_texte_de_la_notification,
  # [les_paramètres_de_la_méthode],
  # <pour qui elle doit être créée>)

  def after_create(advertisement)
    #On créé une notification pour les administrateurs
    AdvertisementNotifications.perform_later(
        :create_for_admin, #la méthode de la notif
        [advertisement.id], # les paramètres de la notification
        user_role: 'super_admin',# on notifie les super-admin
        user_roles: %w[admin],# On notifie les admin et les validateurs de documents
    )
    AdvertisementNotifications.perform_later :create_for_user, [advertisement.id], user: advertisement.user.id
    UserNotificationsMailer.advertisement_created(advertisement.id).deliver # On envoi un e-mail à celui qui à déposé le document.
  end
end
