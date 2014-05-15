# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource except: :find_old_user

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
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    add_breadcrumb I18n.t('users.documents.breadcrumb', user: @user.to_s), user_documents_path(@user)
  end

  def advertisements
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    add_breadcrumb I18n.t('users.advertisements.breadcrumb', user: @user.to_s), user_advertisements_path(@user)
  end

  def avatar
    @user = User.find(params[:user_id])
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    add_breadcrumb I18n.t('users.avatar.title', user: @user.to_s), user_avatar_path(@user)
  end

  def invitations
    @user = User.find params[:user_id]
    add_breadcrumb I18n.t('users.show.breadcrumb', user: @user.to_s), user_path(@user)
    @invitations = Group::Invitation.where receiver: @user
    @email_invitations = Group::EmailInvitation.where email: @user.email
  end

  def no_credit

  end

  def search
    if params[:term]
      @users = User.search_for_autocomplete(params[:term])
    else
      @users = [User.find(params[:id])]
    end
    respond_to do |format|
      format.json { render template: 'users/search' }
    end
  end

  def find_old_user
    user = User.find_by(old_id: params[:id])
    if user
      redirect_to user, status: :moved_permanently
    else
      redirect_to users_path, status: :moved_permanently
    end
  end
end
