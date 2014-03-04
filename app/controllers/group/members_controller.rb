class MembersController < ApplicationController

  def create
    @group = Group::Group.find params[:id]
    if @group.add_members current_user
      redirect_to group_work_group_path(@group), notice: 'Vous êtes membre du groupe'
    else
      redirect_to group_work_group_path(@group), notice: 'Vous ne pouvez pas être membre du groupe'
    end
  end
end