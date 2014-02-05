# -*- encoding : utf-8 -*-
class RepositoryManagerController < ActionController::Base

  def create_folder
    # Get the model
    object = get_object
    repo_item = get_repo_item

    respond_to do |format|
      if object.create_folder(repo_folder_params['name'], source_folder: repo_item, sender: current_user)
        format.html { redirect_to :back, notice: t('repository_manager.success.repo_folder.created') }
        format.json { }
      else
        format.html { redirect_to :back, alert: t('repository_manager.errors.repo_folder.not_created') }
        format.json {  }
      end
    end
  end

  def create_file
    object = get_object
    repo_item = get_repo_item

      if object.create_file(repo_file_params, source_folder: repo_item, sender: current_user)
        redirect_to :back, notice: t('repository_manager.success.repo_file.created')
      else
        redirect_to :back, alert: t('repository_manager.errors.repo_file.not_created')
      end
  end

  private
  def object_params
    params.require(:object).permit(:id, :class)
  end

  def repo_item_params
    params.require(:repo_item).permit(:id)
  end

  def get_repo_item
    repo_item_params[:id] ? RepositoryManager::RepoItem.find(repo_item_params[:id]) : nil
  end


  def get_object!
    if object_params['class'].constantize.method_defined? :get_sharing_authorisations
      object_params['class'].constantize.find(object_params['id'])
    else
      raise RepositoryManager::RepositoryManagerException.new("get_object failed. The class '#{object_params['class']}' is not authorised (try to put 'has_repository' on it model)")
    end
  end

  def get_object
    begin
      get_object!
    rescue RepositoryManager::RepositoryManagerException
      false
    end
  end

  def repo_folder_params
    params.require(:repository_manager_repo_folder).permit(:name)
  end

  def repo_file_params
    params.require(:repository_manager_repo_file).permit(:file, :file_cache)
  end

end
