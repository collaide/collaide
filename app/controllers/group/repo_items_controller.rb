# -*- encoding : utf-8 -*-
class Group::RepoItemsController < ApplicationController
  include Concerns::PermissionConcern
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' },
                     only: :create_file
  before_action do
    # uncomment to disable requests is the form /fr/groupes/travaux/:work_group_id/repertoires...
    # so html request respond to the above URIs and JSON request respond to /api/groups/:work_group_id/repo_items...
    # respond_to do |format|
    #   format.json do
    #     unless request.fullpath.start_with? '/api'
    #       render status: 400, text: 'use api instant'
    #       return
    #     end
    #   end
    # end
  end
  #load_and_authorize_resource class: RepositoryManager::RepoItem
  before_action :find_the_group
  before_action :find_the_repo, only: [:download, :copy, :move, :rename]
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"), :group_groups_path

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    check_permission do
      @group.can_read?(@repo_item) or
          (@repo_item.is_folder? and @group.can? :index, :files, current_user) or
          (!@repo_item.is_folder? and @group.can? :read, :file, current_user)
    end

    if @repo_item.is_folder?
      @children = @repo_item.children.order(name: :asc).order(file: :asc)
    else
      @children = []
    end
  end

  # Affiche le répertoire de base
  def index
    @repo_item = @group.root_repo_items.includes(:owner).includes(:sender).order(name: :asc).order(file: :asc)
    check_permission { @group.can?(:index, :files, current_user) }
  end

  def create_file
    repo_file = params[:repo_file]
    # Pour l'application Java
    if repo_file.nil?
      render status: :bad_request, text: 'bad.'
    end
    repo_item = RepositoryManager::RepoItem.find(repo_file[:id]) if !repo_file[:id].blank?
    check_permission { @group.can? :write, :file, current_user or @group.can_create? repo_item }
    options = {source_folder: repo_item, sender: current_user}
    respond_to do |format|
      if @item = @group.create_file(repo_file[:file], options)
        format.html { redirect_to back, notice: t('repository_manager.success.repo_file.created') }
        format.json { render template: 'group/repo_items/create', status: :created }
      else
        format.html { redirect_to back, alert: t('repository_manager.errors.repo_file.not_created') }
        format.json { render json: options[:errors], status: :unprocessable_entity }
      end
    end
  end

  def create_files

  end

  def create_folder
    folder_params = params.require(:repo_folder).permit(:id, :name)
    repo_item = do_request(folder_params[:id]) do |id|
      RepositoryManager::RepoItem.find id
    end
    check_permission { @group.can? :write, :file, current_user or @group.can_create? repo_item }
    options = {source_folder: repo_item, sender: current_user}
    respond_to do |format|
      if @item = @group.create_folder(params[:repo_folder][:name], options)
        format.html { redirect_to back, notice: t('repository_manager.success.repo_folder.created') }
        format.json { render template: 'group/repo_items/create', status: :created }
      else
        format.html { redirect_to back, alert: t('repository_manager.errors.repo_folder.not_created') }
        format.json { render json: options[:errors], status: :unprocessable_entity }
      end
    end
  end

  def download
    check_permission { @group.can? :read, :file, current_user or @group.can_read? @repo_item }
    # Pris chez Numa
    # méthode d'envoi de fichier :default -> pour le local
    if Rails.env = 'production'
      logger.debug 'On est en production, donc on utilise apache'
      send_file_method = :apache
    else
      send_file_method = :default
    end

    path = @group.download_repo_item(@repo_item)
    logger.debug path.inspect

    # Si le fichier n'est pas trouvé
    render status: :bad_request and return unless File.exist?(path)

    p MIME::Types.type_for(path).inspect

    unless MIME::Types.type_for(path).empty?
      send_file_options = {:type => MIME::Types.type_for(path).first.content_type, disposition: :inline, filename: @repo_item.name}
    else
      send_file_options = {disposition: :inline, filename: @repo_item.name}
    end

    case send_file_method
      when :apache then
        send_file_options[:x_sendfile] = true
      when :nginx then
        head(
            :x_accel_redirect => path.gsub(Rails.root, ''),
        #:content_type => send_file_options[:type]
        ) and return
    end

    # on envoie le fichier
    send_file(path, send_file_options)
    #send_file(path)
  end

  def destroy
    @repo_item = RepositoryManager::RepoItem.find(params[:id])
    check_permission { @group.can? :delete, :file, current_user or @group.can_destroy? @repo_item }

    if @repo_item.is_folder?
      notice = t 'repository_manager.destroy.repo_folder.success', item: @repo_item.name
      notice_failed = t 'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    else
      notice = t 'repository_manager.destroy.repo_file.success', item: @repo_item.name
      notice_failed = t 'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    end
    respond_to do |format|
      if @group.delete_repo_item(@repo_item)
        format.html { redirect_to :back, notice: notice }
        format.json { render json: {notice: notice} }
      else
        format.html { redirect_to :back, alert: notice_failed }
        format.json { render json: repo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def copy
    copy_params = params.require(:repo_item).permit :id
    target = do_request(copy_params[:id]) do |id|
      RepositoryManager::RepoItem.find id
    end
    check_permission { @group.can? :write, :file, current_user or @group.can_update? target }
    respond_to do |format|
      if (@group.copy_repo_item(@repo_item, source_folder: target))

        format.json { render :show }
      else
        format.json { render json: @repo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    move_params = params.require(:repo_item).permit :id
    target = do_request(move_params[:id]) do |id|
      RepositoryManager::RepoFolder.find id
    end
    check_permission { @group.can? :write, :file, current_user or @group.can_update? target }
    respond_to do |format|
      if @group.move_repo_item @repo_item, source_folder: target
        format.json { render :show }
      else
        format.json { render json: @repo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def rename
    check_permission { @group.can? :write, :file, current_user or @group.can_update? @repo_item }
    respond_to do |format|
      if @group.rename_repo_item @repo_item, params[:repo_item][:name]
        format.json { render :show }
      else
        format.json { render json: @repo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def search

  end

  def notify
    @user = User.find(params[:repo_item_id])
    notifications = @user.notifications.where(has_api_viewed: false).
        where(class_name: 'RepositoryManagerNotifications')
    if params[:event]
      case params[:event]
        when 'file_created'
          notifications.where(method_name: 'create_file_in_group')
      end
    end
  notifications.to_a

    response = []

    respond_to do |format|
      if notifications
        notifications.each do |n|
          repo_item = RepositoryManager::RepoItem.find(JSON.parse(n.values)[0])
          if repo_item.owner == @group
            n.has_api_viewed = true
            n.save
            response << {id: repo_item.id, event: n.method_name}
          end
        end
      end
      if response.any?
        format.json { render status: 200, json: response.to_json }
      else
        format.json { render status: 204, text: 'no content' }
      end
    end

  end

  private
  def find_the_group
    @group = Group::Group.find(params[:work_group_id])
  end

  def do_request(params)
    if !params.blank? and block_given?
      yield params
    else
      nil
    end
  end

  def find_the_repo
    @repo_item = RepositoryManager::RepoItem.find(params[:repo_item_id])
  end
end
