# -*- encoding : utf-8 -*-
class Group::RepositoriesController < ApplicationController
  #wload_and_authorize_resource class: Group::WorkGroup

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = RepositoryManager::RepoItem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # Tout ce qui gère le repository
  def index
    @group = Group::Group.find(params[:work_group_id])
    @repo_item = @group.repo_items
    #puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    #puts params[:repo_item_id]
  end

end
