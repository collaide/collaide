# -*- encoding : utf-8 -*-
class Group::SharingsController < ApplicationController
  #load_and_authorize_resource class: Group::SharingsController
  before_action :get_group
  before_action :get_item

  def new
  end

  def create
    members_params = params.require(:repo_item)[:members]
    members = nil
    if members_params.respond_to? :map
      members = members_params.map do |i|
        next unless i[:klass] and i[:id]
        klass = i[:klass].constantize
        klass.send('find', i[:id]) if klass.respond_to? :find
      end
    end
    respond_to do |format|
      if members and (@sharing = @group.share_repo_item(@repo_item, members))
        format.json { render template: 'group/repo_items/show'}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

  def destroy
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

  private

  def get_item
    @repo_item = RepositoryManager::RepoItem.find(params[:repo_item_id])
  end

  def  get_group
    @group = Group::Group.find(params[:work_group_id])
  end
end
