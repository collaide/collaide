# -*- encoding : utf-8 -*-
class Advertisement::SaleBooksController < ApplicationController

  # GET /advertisement/sale_books/1
  # GET /advertisement/sale_books/1.json
  def show
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertisement_sale_book }
    end
  end

  # GET /advertisement/sale_books/new
  # GET /advertisement/sale_books/new.json
  def new
    @advertisement_sale_book = Advertisement::SaleBook.new
    @book = Book.new

    @advertisement_sale_book.book = @book

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @advertisement_sale_book }
    end
  end

  # GET /advertisement/sale_books/1/edit
  def edit
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])
  end

  # POST /advertisement/sale_books
  # POST /advertisement/sale_books.json
  def create
    @advertisement_sale_book = Advertisement::SaleBook.new(params[:advertisement_sale_book])

    respond_to do |format|
      if @advertisement_sale_book.save
        format.html { redirect_to @advertisement_sale_book, notice: 'Sale book was successfully created.' }
        format.json { render json: @advertisement_sale_book, status: :created, location: @advertisement_sale_book }
      else
        format.html { render action: "new" }
        format.json { render json: @advertisement_sale_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advertisement/sale_books/1
  # PUT /advertisement/sale_books/1.json
  def update
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])

    respond_to do |format|
      if @advertisement_sale_book.update_attributes(params[:advertisement_sale_book])
        format.html { redirect_to @advertisement_sale_book, notice: 'Sale book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisement_sale_book.errors, status: :unprocessable_entity }
      end
    end
  end

end
