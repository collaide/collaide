# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
  def home
    unless params[ :locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
      redirect_to eval("root_#{I18n.locale}_path")
    end
    @documents = Document::Document.order('created_at DESC').limit(5).all
    @ads = Advertisement::Advertisement.order('created_at DESC').limit(5).includes(:book).all
    site_news = SiteNew.new
    @news = site_news.get_recent_posts(count: 5).get(:posts)
    add_breadcrumb(t('static_pages.home.bc'))
  end

  def help
    add_breadcrumb(t('static_pages.help.bc'))
  end

  def about
    add_breadcrumb(t('static_pages.about.bc'))
  end

  def contact
    add_breadcrumb(t('static_pages.contact.bc'))
  end

  def change_lang

  end
end
