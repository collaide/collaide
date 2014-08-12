# -*- encoding : utf-8 -*-
class Group::WorkGroupsController < ApplicationController
  load_and_authorize_resource class: Group::WorkGroup

  include Concerns::ActivityConcern

  #breadcrumb
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"), :group_groups_path

  add_breadcrumb I18n.t("group.groups.new.title_page"), :new_group_group_path, :only => %w(new create)
  add_breadcrumb I18n.t("group.work_groups.new.h1_title"), :new_group_work_group_path, :only => %w(new create)

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @group = Group::WorkGroup.find(params[:id])
    @activities = Activity::Activity.order("created_at desc").where('(trackable_id = ? AND trackable_type = ?) OR (recipient_id = ? AND recipient_type = ?) OR (owner_id = ? AND owner_type = ?)', @group.id, @group.class.base_class.to_s, @group.id, @group.class.base_class.to_s, @group.id, @group.class.base_class.to_s)

    # add_breadcrumb @group.name, group_work_group_path(@group)
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
      if @group_work_group.save && create_activity(:create, trackable: @group_work_group, owner: current_user)

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

    p @group_work_group.inspect
    respond_to do |format|
      if @group_work_group.update_attributes(group_work_group_params) && create_activity(:update, trackable: @group_work_group, owner: current_user)
        #p @group_work_group.inspect
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
    authorize!(:members, @group)
    @invitation = Group::DoInvitation.new()
  end

  # Tout ce qui gère le répository
  def repository
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:repo_item_id]) if params[:repo_item_id]
  end

  def notify
    group = Group::WorkGroup.find(params[:work_group_id])
    notifications = group.notifications.find_for_api(
        params[:last_seen], params[:type]
    ).to_a
    respond_to do |format|
      if notifications.any?
        format.json { render status: 200, json: notifications.to_json }
      else
        format.json { render status: 204, text: 'no content' }
      end
    end
  end

  private
  def group_work_group_params
    params.require(:group_work_group).permit(:name, can_index_activity: [], can_index_members: [], can_delete_member: [],
                                             can_read_member: [], can_write_file: [], can_index_files: [], can_read_file: [],
                                             can_delete_file: [], can_index_topics: [], can_read_topic: [], can_write_topic: [],
                                             can_delete_topic: [], can_create_invitation: [], can_manage_invitations: [],
                                             can_delete_group: [])
  end

end
