require 'spec_helper'

describe Advertisement::AdvertisementsController do

  describe "GET 'test'" do
    it "returns http success" do
      get 'test'
      response.should be_success
    end
  end

end
