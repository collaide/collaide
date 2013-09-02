# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "advertisement/sale_books/index" do
  before(:each) do
    assign(:advertisement_sale_books, [
      stub_model(Advertisement::SaleBook),
      stub_model(Advertisement::SaleBook)
    ])
  end

  it "renders a list of advertisement/sale_books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
