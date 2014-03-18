# -*- encoding : utf-8 -*-
class Group::WorkGroupsController < ApplicationController
  load_and_authorize_resource class: Group::WorkGroup

  #breadcrumb
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"),  :group_groups_path

  add_breadcrumb I18n.t("group.groups.new.title_page"), :new_group_group_path, :only => %w(new create)
  add_breadcrumb I18n.t("group.work_groups.new.h1_title"), :new_group_work_group_path, :only => %w(new create)

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @group = Group::WorkGroup.find(params[:id])
    @activities = PublicActivity::Activity.order("created_at desc").where('(trackable_id = ? AND trackable_type = ?) OR (recipient_id = ? AND recipient_type = ?)', @group.id,  @group.class.base_class.to_s, @group.id,  @group.class.base_class.to_s)

    add_breadcrumb @group.name, group_work_group_path(@group)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /group/work_groups/new
  # GET /group/work_groups/new.json
  def new
    @group = Group::WorkGroup.new

    respond_to do |format|
      format.html # new.html.haml
      format.json {
        render json: @group
      }
    end
  end

  # GET /group/work_groups/1/edit
  def edit
    @group= Group::WorkGroup.find(params[:id])
    add_breadcrumb @group.name, group_work_group_path(@group)
    add_breadcrumb I18n.t("group.work_groups.edit.title_page", group: @group.name), edit_group_work_group_path(@group)
  end

  # POST /group/work_groups
  # POST /group/work_groups.json
  def create

    # on crée le work_group avec les parametres du form
    @group_work_group = Group::WorkGroup.new(group_work_group_params)
    @group_work_group.user = current_user

    respond_to do |format|
      if @group_work_group.save && @group_work_group.create_activity(:create, owner: current_user)

        # On ajoute le créateur en tant que ADMIN
        @group_work_group.add_members(current_user, role: Group::Roles::ADMIN)

        format.html { redirect_to @group_work_group, notice: t('group.work_groups.new.forms.success') }
        format.json { render json: @group_work_group, status: :created, location: @group_work_group }
      else
        format.html { render action: "new" }
        format.json { render json: @group_work_group.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /group/work_groups/1
  # PUT /group/work_groups/1.json
  def update

    @group_work_group = Group::WorkGroup.find(params[:id])

    respond_to do |format|
      if @group_work_group.update_attributes(params[:group_work_group]) && @group_work_group.create_activity(:update, owner: current_user)
        format.html { redirect_to @group_work_group, notice: t('group.work_groups.edit.forms.success') }
        format.json { head :no_content }
      else
        add_breadcrumb @group_work_group.name, group_work_group_path(@group_work_group)
        add_breadcrumb I18n.t("group.work_groups.edit.title_page", group: @group_work_group.name), edit_group_work_group_path(@group_work_group)
        format.html { render action: 'edit' }
        format.json { render json: @group_work_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # Show members of the group
  def members
    @group = Group::Group.find(params[:work_group_id])

    @invitation = Group::DoInvitation.new()
  end

  # Tout ce qui gère le répository
  def repository
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:repo_item_id]) if params[:repo_item_id]
  end

  private
  def group_work_group_params
    params.require(:group_work_group).permit(:name)
  end

end
