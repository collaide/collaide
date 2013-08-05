class Member::StudiesController < InheritedResources::Base
  def index
    @studies = Member::Study.all
  end

  def new
    @study = Member::Study.new
  end

  def create
    @study = Member::Study.new params[:member_study]
    if @study.save
      redirect_to @study
    else
      render 'new'
    end
  end

  def update
    @study = Member::Study.find params[:id]
    if @study.update_attributes params[:member_study]
      redirect_to @study
      else
        render 'edit'
    end
  end

  def show
    @study =  Member::Study.find params[:id]
  end
end
