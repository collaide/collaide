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
    # ON CHERCHE SUR LE ISBN CORRESPOND
    @google_book = GoogleBooks.search("isbn:#{params[:advertisement_sale_book][:book][:isbn_10]}").first
    if @google_book
      @book = Book.new
      On récupère tout les attribut dans le googlebook
      #@book.class.accessible_attributes.each do |attribute|
      #  unless attribute.blank?
      #    @book.attribute = @google_book.attribute
      #  end
      #end


      @book.title = @google_book.title
      @book.ratings_count = @google_book.ratings_count
      @book.isbn_10 = @google_book.isbn_10
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]
      #@book = @google_book[:authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title]

    else
      # On crée le book avec le isbn entrée dans le formulaire
      @book = Book.new(params[:advertisement_sale_book][:book])
    end

    # on enlève le book des parametres
    params[:advertisement_sale_book].delete(:book)
    # on crée le sale_book avec les parametres du form
    @advertisement_sale_book = Advertisement::SaleBook.new(params[:advertisement_sale_book])
    #On ajoute le livre dans la vente
    @advertisement_sale_book.book = @book
    #
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
