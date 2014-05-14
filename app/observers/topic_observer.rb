# -*- encoding : utf-8 -*-
class TopicObserver < CollaideObserver
  include Concerns::ActivityConcern
  def after_create(topic)
    create_activity(:create, trackable: topic, owner: topic.writer, recipient: topic.owner)
  end

  def after_destroy(topic)

  end
end

