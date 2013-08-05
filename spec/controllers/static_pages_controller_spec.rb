require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    I18n.available_locales.each do |locale|
      it "returns redirect response" do
        I18n.locale = locale
        get 'home'
        response.should redirect_to(action: 'home', locale: I18n.locale.to_s)
      end
    end
    I18n.available_locales.each do |locale|
      it "returns http success" do
        get 'help', locale: locale
        response.should be_success
      end
    end
  end

  describe "GET 'help'" do
    I18n.available_locales.each do |locale|
      it "returns http success" do
        get 'help', locale: locale
        response.should be_success
      end
    end
  end

  describe "GET 'about'" do
    I18n.available_locales.each do |locale|
      it "returns http success" do
        get 'help', locale: locale
        response.should be_success
      end
    end
  end

  describe "GET 'contact'" do
    I18n.available_locales.each do |locale|
      it "returns http success" do
        get 'help', locale: locale
        response.should be_success
      end
    end
  end

end
