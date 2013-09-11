# -*- encoding : utf-8 -*-
class User::StudiesController < InheritedResources::Base
  def index
    @studies = User::Study.all
  end

  def new
    @study = User::Study.new
  end

  def create
    @study = User::Study.new params[:User_study]
    if @study.save
      redirect_to @study
    else
      render 'new'
    end
  end

  def update
    @study = User::Study.find params[:id]
    if @study.update_attributes params[:User_study]
      redirect_to @study
      else
        render 'edit'
    end
  end

  def show
    @study =  User::Study.find params[:id]
  end
end
