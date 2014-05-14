# -*- encoding : utf-8 -*-
class Group::GroupsController < ApplicationController
  load_and_authorize_resource class: Group::Group

  include Concerns::ActivityConcern

  #breadcrumb
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"),  :group_groups_path

  def new
    add_breadcrumb I18n.t("group.groups.new.title_page"), :new_group_group_path
    @group = Group::Group.new
  end

  def index
    # Pour changer le nombre d'éléments par page, ajouter .per(5) après la méthode page
    #puts current_user.work_groups
    if current_user.nil?
      @groups = []
    else
      @groups = current_user.work_groups
      #@groups ||= current_user.work_groups

    end
  end


  def destroy
    @group = Group::Group.find params[:id]
    create_activity(:destroy, trackable: @group, owner: current_user, params: {name: @group.name})
    @group.destroy()
    redirect_to group_groups_path, notice: t('group.destroy.notice')
  end

  # Show members of the group
  def members
    @group = Group::Group.find(params[:group_id])
  end
end
