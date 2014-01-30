# -*- encoding : utf-8 -*-
class RepositoryManagerController < ActionController::Base

  def create_folder
  # Get the model
  object = object_params['class'].constantize.find(object_params['id'])
  #puts object.inspect

  respond_to do |format|
    if object.create_folder(repo_folder_params['name'])
      format.html { redirect_to :back, note: t('repository_manager.success.repo_folder.created') }
      format.json { }
    else
      format.html { render :back, alert: t('repository_manager.errors.repo_folder.not_created') }
      format.json {  }
    end
  end
  end

  def create_file
    redirect_to :back
  end

  private
  def repository_manager_params
    params[:book] = book_params
    params.require(:advertisement_sale_book).permit(
        :price, :currency, :payement_modes, :delivery_modes, :state, :annotation, :title, :description, :domain_ids,
        :study_level
    )
  end

  def object_params
    params.require(:object).permit(:id, :class)
  end

  def repo_folder_params
    params.require(:repo_folder).permit(:name)
  end

end
