# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Document::Type do
  context 'association' do
    it 'has many documents' do
      type = FactoryGirl.create(:document_type)
      type.documents << FactoryGirl.create(:document)
      docs = type.documents << FactoryGirl.create(:document)
      type.save
      type.reload.documents.should eq(docs)
    end
  end

  context 'translations' do
    it 'has fallback' do
      I18n.locale = :fr
      type = FactoryGirl.create(:document_type)
      type.save
      name_fr = type.reload.name
      I18n.locale = :en
      type.reload.name.should eq(name_fr)
      type.name = name_en = 'hello'
      type.save
    end
    it 'has many languages' do
      I18n.locale = :fr
      type = FactoryGirl.create(:document_type)
      type.save
      name_fr = type.reload.name
      I18n.locale = :en
      type.name = hello_en = 'hello'
      type.save
      type.reload.name.should_not eq(name_fr)
      type.reload.name.should eq(hello_en)
    end
  end
end
