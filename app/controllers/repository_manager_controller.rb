# -*- encoding : utf-8 -*-
class RepositoryManagerController < ActionController::Base

  def create_folder
    # Get the model
    object = get_object

    respond_to do |format|
      if object.create_folder(repo_folder_params['name'])
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


    repo_file = RepoFile.new(repo_file_params)

      if object.create_file(repo_file)
        redirect_to :back, notice: t('repository_manager.success.repo_file.created')
      else
        redirect_to :back, alert: t('repository_manager.errors.repo_file.not_created')
      end
  end

  private
  def object_params
    params.require(:object).permit(:id, :class)
  end

  def get_object
    object_params['class'].constantize.find(object_params['id'])
  end

  def repo_folder_params
    params.require(:repo_folder).permit(:name)
  end

  def repo_file_params
    params.require(:repo_file).permit(:file, :file_cache)
  end

end
