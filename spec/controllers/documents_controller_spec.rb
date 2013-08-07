require 'spec_helper'

describe DocumentsController do


  describe "GET 'index'" do
    I18n.available_locales.each do |locale|
      I18n.locale = locale
      it "should return http success" do
        get :index, locale: I18n.locale
        response.should be_success
      end
    end
  end

  describe "GET 'new'" do
    I18n.available_locales.each do |locale|
      I18n.locale = locale
      it "assigns a new document as @document with locale to '#{I18n.locale}'" do
        get :new, locale: I18n.locale
        assigns(:document).should be_a_new Document::Document
      end
    end
  end

  describe "POST 'create'" do
    #FIXME: les testes ne marchent pas. Aucune idée pourquoi
    describe "with valid params" do
      before :each do
       @attr = FactoryGirl.create(:document)
      end
      it "should create a document" do
        expect {
        post :create, :document_document => @attr.attributes.except('id', 'created_at', 'updated_at'), locale: I18n.locale
        }.to change(Document::Document, :count).by(1)
      end

      it "should redirect to 'index'" do
        response.should redirect_to documents_url
      end
    end

    describe "with invalid params" do
      it "should render 'new'" do

      end
    end
  end

  describe "GET 'show'" do
     it "returns http success" do
       get :show, id: FactoryGirl.create(:document), locale: I18n.locale
       response.should be_successful
     end
  end
end
