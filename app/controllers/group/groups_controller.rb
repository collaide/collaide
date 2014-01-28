# -*- encoding : utf-8 -*-
class Group::GroupsController < ApplicationController
  load_and_authorize_resource class: Group::Group

  #breadcrumb
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"),  :group_groups_path

  def new
    add_breadcrumb I18n.t("group.groups.new.title_page"), :new_group_group_path
    @group = Group::Group.new
  end

  def index
    # Pour changer le nombre d'éléments par page, ajouter .per(5) après la méthode page
    @group = Group::Group.order('created_at DESC').page(params[:page])
  end


  def destroy
    @group = Group::Group.find params[:id]
    @group.destroy()
    redirect_to group_groups_path, notice: t('group.destroy.notice')
  end
end
