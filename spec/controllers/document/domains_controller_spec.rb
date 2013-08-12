# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Document::DomainsController do

  describe "GET 'index'" do
    I18n.available_locales.each do |locale|
      it "returns http success with locale to '#{locale.to_s}'" do
        get 'index', locale: locale
        response.should be_success
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @domain = FactoryGirl.create(:domain)
    end
    I18n.available_locales.each do |locale|
      I18n.locale = locale
      it "returns http success with locale to '#{I18n.locale.to_s}'" do
        get :show, locale: I18n.locale, id: @domain
        response.should be_success
      end
       it "should find the correct domain with localt to '#{I18n.locale}'" do
         get :show, locale: I18n.locale, id: @domain
         assigns(:domain).should == @domain
       end
    end
  end

end
