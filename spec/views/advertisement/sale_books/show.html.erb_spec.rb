# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "advertisement/sale_books/show" do
  before(:each) do
    @advertisement_sale_book = assign(:advertisement_sale_book, stub_model(Advertisement::SaleBook))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
