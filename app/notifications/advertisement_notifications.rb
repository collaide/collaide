# -*- encoding : utf-8 -*-
class AdvertisementNotifications < NotificationSystem::AbstractClass


  def create_for_admin(ad_id)
    advertisement = Advertisement::Advertisement.find_by id: ad_id
    if (advertisement)
      raw I18n.t(
        'notifications.advertisements.create_for_admin',
        user: link_to(h(advertisement.user.to_s), advertisement.user),
        ad: link_to(h(advertisement.title), RailsAdmin::Engine.routes.url_helpers.edit_path('Advertisement::Advertisement', ad_id)))
    else
      deleted_message
    end
  end

  def create_for_user(ad_id)
    advertisement = Advertisement::Advertisement.find_by id: ad_id
    if (advertisement)
      raw I18n.t(
        'notifications.advertisements.create_for_user',
        title: link_to(h(advertisement.title), advertisement_advertisement_path(advertisement))
    )
    else
      deleted_message
    end
  end
end
