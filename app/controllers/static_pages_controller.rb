# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController

  def home
    unless params[ :locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
      redirect_to eval("root_#{I18n.locale}_path")
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def change_lang

  end
end
