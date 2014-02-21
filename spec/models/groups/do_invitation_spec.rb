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
    describe 'has an user invited twice' do
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
        @invitation.errors.messages[:email_list].first.should eq(@receiver.to_single_name)
      end
    end
  end
end
