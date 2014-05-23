require 'spec_helper'

describe Group::EmailInvitation do
  it 'belongs to group' do
    group = FactoryGirl.create :group
    ei = Group::EmailInvitation.new
    ei.group_group = group
    ei.save
    ei.reload.group_group.should eq group
  end

  it 'belongs to user' do
    user = FactoryGirl.create :user
    ei = Group::EmailInvitation.new
    ei.user = user
    ei.save
    ei.reload.user.should eq user
  end
end
