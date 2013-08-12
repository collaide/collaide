# -*- encoding : utf-8 -*-
class StructuresController < ApplicationController
  def new
      @structure = CFile::Structure.new
  end

  def create
    @structure = CFile::Structure.new params[:c_file_structure]
    @structure.user = current_user
    if @structure.save
      redirect_to structure_c_files_path(@structure)
    else
      render action: 'new'
    end
  end
end
