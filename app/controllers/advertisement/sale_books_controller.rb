class Advertisement::SaleBooksController < ApplicationController
  # GET /advertisement/sale_books
  # GET /advertisement/sale_books.json
  def index
    @advertisement_sale_books = Advertisement::SaleBook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertisement_sale_books }
    end
  end

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
    @advertisement_book = Advertisement::SaleBook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisement_book }
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

  # DELETE /advertisement/sale_books/1
  # DELETE /advertisement/sale_books/1.json
  def destroy
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])
    @advertisement_sale_book.destroy

    respond_to do |format|
      format.html { redirect_to advertisement_sale_books_url }
      format.json { head :no_content }
    end
  end
end
