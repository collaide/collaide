class Group::CommentsController < ApplicationController
  include Concerns::PermissionConcern
  def destroy
    group = Group::WorkGroup.find params[:work_group_id]
    check_permission { group.can? :delete, :topic, curent_user }
    topic = group.topics.where(id: params[:topic_id]).take
    comment = topic.comments.where(id: params[:id]).take
    comment.destroy
    redirect_to group_work_group_topic_path(group, topic)
  end

  def edit
    @group = Group::WorkGroup.find(params[:work_group_id])
    check_permission { @group.can? :write, :topic, current_user }
    @topic = @group.topics.where(id: params[:topic_id]).take
    @comment = @topic.comments.where(id: params[:id]).take
  end
end