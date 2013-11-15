# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb I18n.t('users.index.breadcrumb'),  :users_path

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
  end

  def documents
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    add_breadcrumb I18n.t('users.documents.breadcrumb', user: @user.to_s), user_documents_path(@user)
  end

  def advertisements
    #@message = UserMessage.new
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    add_breadcrumb I18n.t('users.advertisements.breadcrumb', user: @user.to_s), user_advertisements_path(@user)
  end

  def no_credit

  end
end
