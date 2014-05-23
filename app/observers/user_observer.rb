# -*- encoding : utf-8 -*-
class UserObserver < ActiveRecord::Observer
  include Concerns::ActivityConcern

  def after_create(user)
    create_activity(:create, trackable: user, public: true)
  end

  #def after_destroy(user)
  #
  #end
end

