# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "advertisement/sale_books/edit" do
  before(:each) do
    @advertisement_sale_book = assign(:advertisement_sale_book, stub_model(Advertisement::SaleBook))
  end

  it "renders the edit advertisement_sale_book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisement_sale_books_path(@advertisement_sale_book), :method => "post" do
    end
  end
end
