# -*- encoding : utf-8 -*-
class Group::SharingsController < ApplicationController
  #load_and_authorize_resource class: Group::SharingsController

  def new
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:repo_item_id])

  end

  def create
  end

  def destroy
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    if @repo_item.is_folder?
      notice = t'repository_manager.destroy.repo_folder.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    else
      notice = t'repository_manager.destroy.repo_file.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_file.failed', item: @repo_item.name
    end

    if @group.delete_repo_item(@repo_item)
      redirect_to :back, notice: notice
    else
      redirect_to :back, alert: notice_failed
    end
  end
end
