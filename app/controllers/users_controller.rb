# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb I18n.t('users.index.breadcrumb'),  :users_path

  def show
    @user = User.find(params[:id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.name_to_show), user_path(@user)

  end

  def documents
    @user = User.find(params[:user_id])
  end

  def advertisements
    @message = UserMessage.new
    @user = User.find(params[:user_id])
  end

  def no_credit

  end
end
