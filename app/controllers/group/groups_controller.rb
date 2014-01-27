# -*- encoding : utf-8 -*-
class Group::GroupsController < ApplicationController
  load_and_authorize_resource class: Group::Group

  #breadcrumb
  add_breadcrumb I18n.t("groups.index.breadcrumb"),  :group_groups_path

  def new
    add_breadcrumb I18n.t("groups.new.title"), :new_group_group_path
    #Il n'y a pas de création de nouvea groups, car c'est un object abstrait qui doit être hérité (par WorkGroup, par ex)
    # La page new propose donc ce que le user veut créer
    redirect_to :new_group_group_path
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
