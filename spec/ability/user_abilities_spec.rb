require 'spec_helper'
require 'cancan/matchers'

describe 'abilities of' do
  describe 'user panel' do
    subject(:ability) { Ability.new(user) }
    context 'when a user is not connected' do
      let(:user) { nil }
      it { should be_able_to :documents, User }
      it { should be_able_to :advertisements, User }
      it { should_not be_able_to :manage, User }
    end
    context 'when a user is connected' do
      let(:user) {FactoryGirl.create(:normal_user)}
      it { should_not be_able_to :manage, FactoryGirl.create(:user) }
      it { should_not be_able_to :manage, FactoryGirl.create(:normal_user) }
      it { should be_able_to :manage, user }
    end
  end
end