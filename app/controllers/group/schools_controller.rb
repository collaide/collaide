# -*- encoding : utf-8 -*-
class Group::WorkGroupsController < ApplicationController
  load_and_authorize_resource class: Group::WorkGroup


  #breadcrumb
  add_breadcrumb I18n.t("groups.index.breadcrumb"),  :group_groups_path


  add_breadcrumb I18n.t("groups.new.title"), :new_group_group_path, :only => %w(new create)
  add_breadcrumb I18n.t("work_groups.new.title"), :new_group_work_group_path, :only => %w(new create)

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @message = UserMessage.new

    @work_group = Group::WorkGroup.find(params[:id])

    add_breadcrumb I18n.t("work_groups.show.title", book: @work_group.name), group_work_group_path(@work_group)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_group }
    end
  end

  # GET /group/work_groups/new
  # GET /group/work_groups/new.json
  def new
    @work_group = Group::WorkGroup.new

    respond_to do |format|
      format.html # new.html.haml
      format.json {
        render json: @work_group
      }
    end
  end

  # GET /group/work_groups/1/edit
  def edit
    @work_group = Group::WorkGroup.find(params[:id])
    add_breadcrumb I18n.t("work_groups.show.title", book: @work_group.name), group_work_group_path(@work_group)
    add_breadcrumb I18n.t("work_groups.edit.title", book: @work_group.name), edit_group_work_group_path(@work_group)
  end

  # POST /group/work_groups
  # POST /group/work_groups.json
  def create

    # on crée le work_group avec les parametres du form
    @group_work_group = Group::WorkGroup.new(params[:group_work_group])
    #On ajoute le livre dans la vente
    @group_work_group.user = current_user
    #
    respond_to do |format|
      if @group_work_group.save
        format.html { redirect_to @group_work_group, notice: t('work_groups.new.forms.succes') }
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
      if @group_work_group.update_attributes(params[:group_work_group])
        format.html { redirect_to @group_work_group, notice: t('work_groups.edit.forms.succes') }
        format.json { head :no_content }
      else
        add_breadcrumb I18n.t("work_groups.show.title", book: @group_work_group.name), group_work_group_path(@group_work_group)
        add_breadcrumb I18n.t("work_groups.edit.title", book: @group_work_group.name), edit_group_work_group_path(@group_work_group)
        format.html { render action: 'edit' }
        format.json { render json: @group_work_group.errors, status: :unprocessable_entity }
      end
    end
  end

end
