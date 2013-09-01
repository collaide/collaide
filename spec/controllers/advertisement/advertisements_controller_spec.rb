# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Advertisement::AdvertisementsController do

  describe "GET 'test'" do
    it "returns http success" do
      get 'test', locale: I18n.locale
      response.should be_success
    end
  end

end
