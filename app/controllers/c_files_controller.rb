class CFilesController < ApplicationController
  def index
    @files = CFile::Structure.find params[:structure_id]

  end

  def new
    @file = CFile::CFile.new
    @files = CFile::Structure.find params[:structure_id]
  end

  def create
    @structure = CFile::Structure.find params[:structure_id]
    unless params[:c_file_structure].nil?
      @files = params[:c_file_structure][:files].each do |data|
        p = {}
        p[:file] = data
         file = CFile::CFile.new p
        file.save
        @structure.files << file
      end
    end

    if @structure.save
      redirect_to structure_c_files_path, structure_id: @structure
    else
      render 'index', flash[:error] = "Un problème est survenu"
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def show
  end
end
