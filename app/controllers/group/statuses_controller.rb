class Group::StatusesController < ApplicationController
  #load_and_autho
  #load_and_authorize_resource class: Group::Status, through: :group

  before_action :get_required_objects, only: [:index, :show]

  #GET /group/:id/statuses
  def index
    @status = Status.new
    authorize!(:index, Group::Group.find(params[:work_group_id]))
    @statuses = Group::Group.find(params[:work_group_id]).statuses.order('created_at DESC').includes({comments: :owner}, :writer)
  end

  def show
    @status = Status.find params[:id]
    authorize!(:show, @status)
  end

  private

  def get_required_objects
    @comment = Comment.new
    @group = Group::Group.find(params[:work_group_id])
  end
end