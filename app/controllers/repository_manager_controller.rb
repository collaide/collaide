# -*- encoding : utf-8 -*-
class RepositoryManagerController < ActionController::Base

  #def create_folder
  #  # Get the model
  #  object = get_object
  #  repo_item = get_repo_item
  #
  #  respond_to do |format|
  #    if object.create_folder(params[:repo_folder_name], source_folder: repo_item, sender: current_user)
  #      format.html { redirect_to :back, notice: t('repository_manager.success.repo_folder.created') }
  #      format.json { }
  #    else
  #      format.html { redirect_to :back, alert: t('repository_manager.errors.repo_folder.not_created') }
  #      format.json {  }
  #    end
  #  end
  #end
  #
  #def create_file
  #  object = get_object
  #  repo_item = get_repo_item
  #
  #  puts params[:repo_file_file].class.name
  #
  #    if object.create_file(params[:repo_file_file], source_folder: repo_item, sender: current_user)
  #      redirect_to :back, notice: t('repository_manager.success.repo_file.created')
  #    else
  #      redirect_to :back, alert: t('repository_manager.errors.repo_file.not_created')
  #    end
  #end
  #
  #private
  #def object_params
  #  params.require(:object).permit(:id, :class)
  #end
  #
  #def get_repo_item
  #  params[:repo_item] ? RepositoryManager::RepoItem.find(params[:repo_item][:id]) : nil
  #end
  #
  #def get_object!
  #  if object_params['class'].constantize.method_defined? :get_sharing_authorisations
  #    object_params['class'].constantize.find(object_params['id'])
  #  else
  #    raise RepositoryManager::RepositoryManagerException.new("get_object failed. The class '#{object_params['class']}' is not authorised (try to put 'has_repository' on it model)")
  #  end
  #end
  #
  #def get_object
  #  begin
  #    get_object!
  #  rescue RepositoryManager::RepositoryManagerException
  #    false
  #  end
  #end

end
