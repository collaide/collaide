# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Advertisement::SaleBooks" do
  describe "GET home" do
    it "works" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_path
      response.status.should be(200)
    end
    it 'redirect' do
      get '/'
      response.status.should be(302)
    end
  end
end
