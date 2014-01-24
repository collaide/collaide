# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Advertisement::SaleBooks" do
  describe "GET /advertisement_sale_books" do
    it "all books" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      I18n.locale = :fr
      get root_path
      response.status.should be(200)
    end
    describe 'get new ads'  do
      #get new_advertisement_advertisement_fr_path
      #response.status.should be 200
    end

  end
end
