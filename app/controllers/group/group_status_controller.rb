class GroupStatusController < ApplicationController

  #GET /group/:id/statuses
  def index
    @statuses = Group.find(:id).statuses.include(:comments)
  end
end