# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Document::Document" do
    it 'list empty document index' do
      get document_documents_path
      response.status.should be(200)
    end
    describe 'create a document' do
     it 'redirect back' do
        get new_document_document_fr_path
        response.status.should be(302)
     end

     it 'show form' do
       sign_in_as_a_valid_user
       get new_document_document_fr_path
       response.status.should be(200)
     end

   it 'create a new one' do
     post '/fr/documents'
     response.status.should be(302)
     follow_redirect!

     response.status.should be(200)
     end
    end

end

def login(user)
  post '/fr/membre', user: {email: user.email, password: user.password}
end
