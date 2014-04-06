class Group::TopicsController < ApplicationController
  #load_and_autho
  #load_and_authorize_resource class: Group::Status, through: :group

  before_action :get_required_objects, only: [:index, :show]

  #GET /group/:id/statuses
  def index
    @topic = Topic.new
    authorize!(:index, Group::Group.find(params[:work_group_id]))
    @topics = Group::Group.find(params[:work_group_id]).topics.order('created_at DESC').includes({comments: :owner}, :writer)
  end

  def new
    @topic = Topic.new
    @group = Group::Group.find(params[:work_group_id])

    #authorize!(:new, Group::Group.find(params[:work_group_id]))
  end

  def show
    @topic = Topic.find params[:id]
    authorize!(:show, @topic)
  end

  private

  def get_required_objects
    @comment = Comment.new
    @group = Group::Group.find(params[:work_group_id])
  end
end