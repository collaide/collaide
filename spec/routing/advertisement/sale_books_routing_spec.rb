# -*- encoding : utf-8 -*-
require "spec_helper"

describe Advertisement::SaleBooksController do
  describe "routing" do

    it "routes to #index" do
      get("/advertisement/sale_books").should route_to("advertisement/sale_books#index")
    end

    it "routes to #new" do
      get("/advertisement/sale_books/new").should route_to("advertisement/sale_books#new")
    end

    it "routes to #show" do
      get("/advertisement/sale_books/1").should route_to("advertisement/sale_books#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertisement/sale_books/1/edit").should route_to("advertisement/sale_books#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertisement/sale_books").should route_to("advertisement/sale_books#create")
    end

    it "routes to #update" do
      put("/advertisement/sale_books/1").should route_to("advertisement/sale_books#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertisement/sale_books/1").should route_to("advertisement/sale_books#destroy", :id => "1")
    end

  end
end
