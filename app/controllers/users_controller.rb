# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb I18n.t('users.index.breadcrumb'),  :users_path
  #FIXME le path ne marche pas...
 # add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path, :only => %w(show documents advertisements)


  def index
    @users = User.page(params[:page]).per(32)
  end

  def show
    @user = User.find(params[:id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
  end

  def documents
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.documents.breadcrumb', user: @user.to_s), user_documents_path(@user)
  end

  def advertisements
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.advertisements.breadcrumb', user: @user.to_s), user_advertisements_path(@user)
  end

  def no_credit

  end

  def search
    term = params[:term]
    #email = params[:email]
    #name = params[:name]
    #if !email.blank? and !name.blank?
    #  user = User.where email: email, name: name
    #elsif !email.blank?
    #  user = User.where email: email
    #elsif !name.blank?
    #  user = User.where name: name
    #else
    #  render status: 402
    #  return
    #end
    user = User.search_for_autocomplete(term)
    status = 200
    status = 204 if user.nil?
    #user_params = {id: user.id, name: user.name, email: user.email}
    respond_to do |format|
      format.json { render status: status, json: user }
    end
  end
end
