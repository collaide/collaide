# -*- encoding : utf-8 -*-
class AdvertisementNotifications < NotificationSystem::AbstractClass


  def create_for_admin(ad_id)
    advertisement = Advertisement::Advertisement.find ad_id
    raw I18n.t(
        'notifications.advertisements.create_for_admin',
        user: h(advertisement.user.to_s),
        ad: link_to(h(advertisement.title), RailsAdmin::Engine.routes.url_helpers.edit_path('Advertisement::Advertisement', ad_id)))
  end

  def create_for_user(ad_id)
    advertisement = Advertisement::Advertisement.find ad_id
    raw I18n.t(
        'notifications.advertisements.create_for_user',
        title: link_to(h(advertisement.title), advertisements_advertisement_path(document))
    )
  end
end
