# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Document::Document do
  context 'association' do
    it 'belongs to document_type' do
      doc = FactoryGirl.create(:document)
      dt = FactoryGirl.create(:document_type)
      doc.document_type = dt
      doc.save
      doc.reload.document_type.should eq(dt)
    end
    it 'has and belongs to many domains' do
      doc = FactoryGirl.build(:document)
      doc.domains = []
      doc.domains << FactoryGirl.create(:domain)
      d2 = doc.domains << FactoryGirl.create(:domain)
      doc.save
      doc.reload.domains.should eq(d2)
    end
  end

  it 'belongs to a user' do
    doc = FactoryGirl.build(:document)
    u = doc.user = FactoryGirl.create(:user)
    doc.save
    doc.reload.user.should eq(u)
  end

  it 'has many download by users' do
    doc = FactoryGirl.build(:document)
    users = doc.user_downloader << FactoryGirl.create(:user)
    doc.save
    doc.reload.user_downloader.should eq(users)
  end

  it 'has a note' do
    doc = FactoryGirl.build(:document)
    doc.save
    doc.rate(2, FactoryGirl.build(:user))
    doc.save
    doc2 = Document::Document.includes(:note_average).find(doc.id)
    doc2.average.avg.should eq(2.0)
  end
end
