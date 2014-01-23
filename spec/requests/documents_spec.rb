# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Document::Document" do
  describe "GET /documents" do
    it 'works without documents' do
      get document_documents_path
      response.status.should be(200)
    end
  end
end
