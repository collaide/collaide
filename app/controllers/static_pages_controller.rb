# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
  def home
    unless params[ :locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
      redirect_to eval("root_#{I18n.locale}_path")
    end

    if current_user
      # On va chercher les activités liés au membre
      @activities = current_user.activities.order("created_at desc").limit(20).includes(:trackable, :owner, :recipient)
    else
      # Prendre que les activités publics
      @activities = Activity::Activity.order("created_at desc").public.limit(20).includes(:trackable, :owner, :recipient)
    end
    @site_news = SiteNew.new
    add_breadcrumb(t('static_pages.home.bc'))
  end

  def help
    add_breadcrumb(t('static_pages.help.bc'))
  end

  def about
    add_breadcrumb(t('static_pages.about.bc'))
  end

  def board

  end

  def contact
    add_breadcrumb(t('static_pages.contact.bc'))
    @contact = Contact.new
  end

  def change_lang

  end

  def rules
    add_breadcrumb(t('static_pages.rules.bc'))
  end

  def partners
    add_breadcrumb(t('static_pages.partners.bc'))
  end

  def send_email
    @contact = Contact.new params[:contact]
    if @contact.valid?
      ActionMailer::Base.mail(
          from: @contact.email, :to => 'contact@collaide.com',
          subject: @contact.subject,
          body: @contact.content
      ).deliver
      redirect_to contact_path, notice: t('static_pages.contact.success', email: @contact.email, subject: @contact.subject)
    else
      render action: :contact
    end
  end

  def mail_test
    @message = Message.find 1

    render template: 'message_mailer/new_message_email'
  end
end
