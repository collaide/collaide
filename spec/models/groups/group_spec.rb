require 'spec_helper'

describe Group::Group do
  context 'associations' do

    it 'can create a group' do
      g = FactoryGirl.build(:group)
    end

    it 'Group has main_group and sub_groups' do
      g = FactoryGirl.create(:group)
      g2 = FactoryGirl.create(:group)
      g3 = FactoryGirl.create(:group)
      g2.main_group = g
      g2.save
      g3.main_group = g
      g3.save

      g2.reload.main_group.should eq(g)
      g3.reload.main_group.should eq(g)
      g.reload.sub_groups.should eq([g2,g3])
    end

  end
end