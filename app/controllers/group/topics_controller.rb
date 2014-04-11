class Group::TopicsController < ApplicationController
  #load_and_authorize_resource class: Group::WorkGroup, as: :group
  #load_and_authorize_resource class: Topic
  before_action :sign_in_user
  before_action :get_required_objects

  #GET /group/:id/statuses
  def index
    raise CanCan::AccessDenied unless @group.can? :index, :topics, current_user
    @topic = Topic.new
    @topics = @group.topics.order('created_at DESC').includes({comments: :owner}, :writer)
  end

  def new
    raise CanCan::AccessDenied unless @group.can? :write, :topic, current_user
    @topic = Topic.new
  end

  def show
    raise CanCan::AccessDenied unless @group.can? :read, :topic, current_user
    @topic = Topic.find params[:id]
  end

  private
  def get_required_objects
    @comment = Comment.new
    @group = Group::Group.find(params[:work_group_id])
  end
end