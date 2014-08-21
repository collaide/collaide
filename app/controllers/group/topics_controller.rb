class Group::TopicsController < ApplicationController
  include Concerns::PermissionConcern
  #load_and_authorize_resource class: Group::WorkGroup, as: :group
  #load_and_authorize_resource class: Topic
  before_action :sign_in_user
  before_action :get_required_objects
  add_breadcrumb I18n.t("group.groups.index.breadcrumb"),  :group_groups_path

  #GET /group/:id/statuses
  def index
    #raise CanCan::AccessDenied unless @group.can? :index, :topics, current_user
    check_permission { @group.can? :index, :topics, current_user }
    @topic = Topic.new
    @topics = @group.topics.order('comments.created_at DESC').includes({comments: :user}, :user_writer).page(params[:page])
  end

  def new
    check_permission{ @group.can? :write, :topic, current_user }
    @topic = Topic.new
  end

  def show
    check_permission{ @group.can? :read, :topic, current_user }
    @topic = @group.topics.order('comments.created_at DESC').includes({comments: :user}, :user_writer).take
    @comments = @topic.comments
  end

  private
  def get_required_objects
    @comment = Comment.new
    @group = Group::Group.find(params[:work_group_id])
  end
end