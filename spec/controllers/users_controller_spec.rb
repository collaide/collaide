require 'spec_helper'
require "cancan/matchers"

describe UsersController do


  describe "GET 'show'" do
    before(:each) do
      request.env["HTTP_REFERER"] = 'back'
    end
    describe "with user not connected" do
      I18n.available_locales.each do |locale|
        I18n.locale = locale
        it "current user should be nil" do
          subject.current_user.should be_nil
        end

        it "should redirect back with locale to '#{I18n.locale}'" do
          get :show, locale: I18n.locale, id: FactoryGirl.create(:user)
          response.should redirect_to 'back'
        end
      end
    end

    describe "with user connected" do
      login_user
      I18n.available_locales.each do |locale|
        I18n.locale = locale
        it "should returns http success with locale to '#{I18n.locale.to_s}'" do
          get :show, locale: I18n.locale, id: subject.current_user
          response.should be_success
        end
        it "should find the correct user with local to '#{I18n.locale}'" do
          get :show, locale: I18n.locale, id: subject.current_user
          assigns(:user).should == subject.current_user
        end
      end
    end
  end

end
