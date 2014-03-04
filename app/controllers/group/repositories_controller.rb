# -*- encoding : utf-8 -*-
class Group::RepositoriesController < ApplicationController
  #load_and_authorize_resource class: Group::RepositoriesController

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    render status: :forbidden, :text => "No permission to see this repo_item" and return unless @group.can_read?(@repo_item)

    if @repo_item.is_folder?
      @children = @repo_item.children.order(name: :asc).order(file: :asc)
    else
      @children = []
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # Tout ce qui gère le repository
  def index
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = @group.root_repo_items.order(name: :asc).order(file: :asc)
    #puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    #puts params[:repo_item_id]
  end

  def create_file
    @group = Group::Group.find(params[:work_group_id])
    repo_item = RepositoryManager::RepoItem.find(params[:repo_item]) if params[:repo_item]

    if @group.create_file(params[:repo_file_file], source_folder: repo_item, sender: current_user)
      redirect_to :back, notice: t('repository_manager.success.repo_file.created')
    else
      redirect_to :back, alert: t('repository_manager.errors.repo_file.not_created')
    end
  end

  def create_folder
    @group = Group::Group.find(params[:work_group_id])
    repo_item = RepositoryManager::RepoItem.find(params[:repo_item]) if params[:repo_item]

    if @group.create_folder(params[:repo_folder_name], source_folder: repo_item, sender: current_user)
      redirect_to :back, notice: t('repository_manager.success.repo_folder.created')
    else
      redirect_to :back, alert: t('repository_manager.errors.repo_folder.not_created')
    end
  end

  def download
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:repository_id])

    # Pris chez Numa
    # méthode d'envoi de fichier :default -> pour le local
    if Rails.env = 'production'
      logger.debug 'On est en production, donc on utilise apache'
      send_file_method = :apache
    else
      send_file_method = :default
    end

    path = @group.download(@repo_item)
    logger.debug path.inspect

    # Si le fichier n'est pas trouvé
    render status: :bad_request and return unless File.exist?(path)

    send_file_options = { :type => MIME::Types.type_for(path).first.content_type, disposition: :inline }

    case send_file_method
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end

    # on envoie le fichier
    send_file(path, send_file_options)
  end

  def destroy
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    if @repo_item.is_folder?
      notice = t'repository_manager.destroy.repo_folder.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    else
      notice = t'repository_manager.destroy.repo_file.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    end

    if @group.delete_repo_item(@repo_item)
      redirect_to :back, notice: notice
    else
      redirect_to :back, alert: notice_failed
    end
  end
end
