# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Document::Download do
  context 'association' do
    it 'belongs_to document' do
      down = Document::Download.new
      down.number_of_downloads= 1
      doc = FactoryGirl.create(:document)
      down.document = doc
      user = FactoryGirl.create(:user)
      down.user = user
      down.save
      down.reload.user.should eq(user)
      down.reload.document.should eq(doc)
    end
  end
end
