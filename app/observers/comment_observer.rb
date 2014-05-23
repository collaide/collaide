# -*- encoding : utf-8 -*-
class CommentObserver < ActiveRecord::Observer
  include Concerns::ActivityConcern

  def after_create(comment)
    # comment.commentable.owner comme ça on a pas le topic comme recipient,
    # mais le owner du topic (ex : groupe)
    create_activity(:create, trackable: comment, owner: comment.owner, recipient: comment.commentable.owner)
  end

  def after_destroy(comment)

  end
end

