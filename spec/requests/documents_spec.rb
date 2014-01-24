# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Document::Document" do
    it 'list empty document index' do
      get document_documents_path
      response.status.should be(200)
    end
    describe 'create a document' do
     it 'redirect to home' do
       get document_documents_path
       expect(response).to render_template('document/documents/index')
        get new_document_document_fr_path
        expect(response).to redirect_to('/fr')
       follow_redirect!
     end

     it 'show form document' do
       sign_in_as_a_valid_user
       get '/fr/documents/nouveau'
       expect(response).to render_template('document/documents/_form')
     end

   it 'create a new one with wrong args' do
     sign_in_as_a_valid_user
     post document_documents_path, document_document: {title: 'asjhdv'}
     expect(response).to render_template(:new)
   end
    it 'create a new one with good args' do
      sign_in_as_a_valid_user
      doc = FactoryGirl.build(:document)
      post '/fr/documents', {"document_document"=>{"title"=>"Domain 8", "description"=>"c'est une déscription", "author"=>"salut", "number_of_pages"=>"2", "realized_at"=>"2012-01-24", "language"=>"Français", "file"=>Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'download', 'asDF.tiff')), "document_type_id"=>"1",  "study_level"=>"university", domain_ids: [1]}}
      #puts response.public_methods
      puts response.body
      response.status.should eq(302)
       follow_redirect!
       expect(response.body).to include('document a été créé')
    end
      it 'index no empty list' do
        doc = FactoryGirl.create(:document)
        doc.status = :pending
        doc.save
        get document_documents_path
        puts doc.title
        expect(response.body).to include(doc.title)

      end
  end

end

def login(user)
  post '/fr/membre', user: {email: user.email, password: user.password}
end
