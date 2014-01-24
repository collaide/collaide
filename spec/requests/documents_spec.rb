# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Document::Document" do
  describe 'many documents' do
    it 'renders an empty list' do
      get document_documents_path
      response.status.should be(200)
    end
    it 'renders a non empty list' do
      doc = create_valid_doc
      visit document_documents_path
      puts doc.title
      page.should have_content(doc.title)
    end
  end

  describe 'one document' do
    it 'renders a document' do
      sign_in_as_a_valid_user
      doc = create_valid_doc
      visit document_documents_path
      click_link doc.title
      page.should have_content(doc.title)
      page.should have_content('Télécharger')
    end
    it 'downloads a document' do
      sign_in_as_a_valid_user
      doc = create_valid_doc
      get "fr/documents/#{doc.id}/telecharger"
    end
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
      post '/fr/documents', {"document_document"=>{"title"=>"Domain 8", "description"=>"c'est une déscription", "author"=>"salut", "number_of_pages"=>"2", "realized_at"=>"2012-01-24", "language"=>"Français", "asset"=>Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'download', 'asDF.tiff')), "document_type_id"=>"1",  "study_level"=>"university", domain_ids: [1]}}
      #puts response.public_methods
      puts response.body
      response.status.should eq(302)
       follow_redirect!
       expect(response.body).to include('document a été créé')
    end

  end

end

def create_valid_doc
  doc = FactoryGirl.create(:document)
  doc.status = :accepted
  doc.save
  doc
end
