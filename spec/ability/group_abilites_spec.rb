require 'spec_helper'
require 'cancan/matchers'

describe 'abilities of' do
  describe 'group' do
    subject(:ability) { Ability.new(user, nil) }
    let(:user) { nil }
    let!(:group) { Group::Group.new }
    describe 'when a user is not connected he ' do
      context 'access to Group::Group#index and #new' do
        it { should be_able_to(:index, group) }
        it { should be_able_to(:new, group) }
      end
      context 'do not acces to Group::Group#destroy' do
        it { should_not be_able_to :destroy, group }
      end
    end
  end
  describe 'work_group' do
    subject(:ability) { Ability.new(user, nil) }
    let(:user) { FactoryGirl.create :normal_user }
    let!(:work_group) { FactoryGirl.create(:work_group) }
    let!(:status) { FactoryGirl.create(:status) }
    let!(:new_work_group) { Group::WorkGroup.new }
    let!(:invitation) { FactoryGirl.create :invitation }
    let!(:email_invitation) { FactoryGirl.create :email_invitation }
    describe 'when a user is connected and not member of the work_group he ' do
      before(:each) do
        invitation.group = work_group
        email_invitation.group_group = work_group
        invitation.save
        email_invitation.save
      end
      context 'create a work_group' do
        it { should be_able_to :new, new_work_group }
        it { should be_able_to :create, new_work_group }
      end
      context 'do not access to nothing else' do
        it { should_not be_able_to :destroy, work_group }
        it { should_not be_able_to :show, work_group }
        it { should_not be_able_to :edit, work_group }
        it { should_not be_able_to :update, work_group }
        it { should_not be_able_to :members, work_group }
        it { should_not be_able_to :index, status }
        it { should_not be_able_to :show, status }
        it { should_not be_able_to :create, status }
        it { should_not be_able_to :update, status }
        it { should_not be_able_to :update, email_invitation}
        it { should_not be_able_to :destroy, email_invitation}
        it { should_not be_able_to :create, invitation }
        it { should_not be_able_to :update, invitation }
        it { should_not be_able_to :destroy, invitation }
      end
    end
    describe 'when a user is admin of the work_group he ' do
      before(:each) do
        work_group.add_members user, role: Group::Roles::ADMIN
        work_group.save
        status.owner = work_group
        status.save
        invitation.group = work_group
        email_invitation.group_group = work_group
        invitation.save
        email_invitation.save
      end
      context 'do what he want' do
        it { should be_able_to :destroy, work_group }
        it { should be_able_to :show, work_group }
        it { should be_able_to :edit, work_group }
        it { should be_able_to :update, work_group }
        it { should be_able_to :members, work_group }
        it { should be_able_to :index, status }
        it { should be_able_to :show, status }
        it { should be_able_to :create, status }
        it { should be_able_to :update, status }
        it { should be_able_to :update, email_invitation}
        it { should be_able_to :destroy, email_invitation}
        it { should be_able_to :create, invitation }
        it { should be_able_to :update, invitation }
        it { should be_able_to :destroy, invitation }
      end
    end
  end
end