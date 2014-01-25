require 'spec_helper'

describe Advertisement::SaleBook do
  context 'association' do
    it 'belongs_to book' do
      b = FactoryGirl.build(:book)
      s = FactoryGirl.build(:sale_book)
      s.book = b
      s.save
      puts s.errors.inspect
      s.reload.book.should eq(b)
    end

    it 'has and belongs to many domains' do
      I18n.locale = :fr
      s =  FactoryGirl.build(:sale_book)
      d1 = FactoryGirl.create(:domain)
      d2 = FactoryGirl.create(:domain)
      s.domains << d1
      domains = s.domains << d2
      s.save
      s.reload.domains.should eq(domains)
    end
  end
end