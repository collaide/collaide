class Group::StatusesController < ApplicationController
  load_and_authorize_resource class: Group::Status
  before_action :get_required_objects, only: [:index, :show]

  #GET /group/:id/statuses
  def index

    @status = Status.new
    @statuses = Group::Group.find(params[:work_group_id]).statuses.order('created_at DESC').includes({comments: :owner}, :writer)
  end

  def show
    @status = Status.find params[:id]
  end

  private

  def get_required_objects
    @comment = Comment.new
    @group = Group::Group.find(params[:work_group_id])
  end
end