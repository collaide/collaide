# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Group::Group do
  context 'validations' do
    describe 'has empty email_list field ' do
      before :each do
        @invitation = Group::DoInvitation.new
      end
      it 'return false' do
        @invitation.valid?.should eq(false)
      end
      it 'has error messages' do
        @invitation.valid?
        @invitation.errors.empty?.should_not be_true
      end
    end
    it 'has empty user ids and non valid emails' do
      invitation = Group::DoInvitation.new email_list: 'asd, asdasd, sadasdƒ@'
      invitation.valid?.should be_false
    end
    describe 'has a user invited twice' do
      before :each do
        group = FactoryGirl.create :group
        sender = FactoryGirl.create :user
        @receiver = FactoryGirl.create :user
        group.send_invitations @receiver, sender: sender, message: 'salut'
        @invitation = Group::DoInvitation.new users_id: "#{@receiver.id}, 4", email_list: "asda...daßd.sd, #{@receiver.email}, numa_m@bluewin.ch", group_id: group.id
      end
      it 'validates with false return value' do
        @invitation.valid?.should be_false
      end
      it 'has corresponding error message' do
        @invitation.valid?
        @invitation.errors.messages[:email_list].first.should include(@receiver.to_single_name)
      end
    end
    describe 'has a user already member of the group' do
      before(:each) do
        @group = FactoryGirl.create :group
        @sender = FactoryGirl.create :user
        @group.u_members << @sender
        @group.save
        @receiver = FactoryGirl.create :user
        @invitation = Group::DoInvitation.new users_id: "#{@sender.id}, 409", email_list: 'asda...daßd.sd,  numa_m@bluewin.ch', group_id: @group.id
      end
      it 'has a member' do
        @group.reload.members.should include(@sender)
      end
      it 'return false' do
        @invitation.valid?.should be_false
      end
      it 'has correct error message' do
        @invitation.valid?
        @invitation.errors.messages[:email_list].first.should include(@sender.to_s)
      end
    end
  end
end
