# -*- encoding : utf-8 -*-
class Advertisement::SaleBooksController < ApplicationController

  # GET /advertisement/sale_books/1
  # GET /advertisement/sale_books/1.json
  def show
    @sale_book = Advertisement::SaleBook.find(params[:id])
    @google_book = GoogleBooks.search("isbn:#{@sale_book.book.isbn_13}").first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_book }
    end
  end

  # GET /advertisement/sale_books/new
  # GET /advertisement/sale_books/new.json
  def new
    @advertisement_sale_book = Advertisement::SaleBook.new
    book = Book.new
    @advertisement_sale_book.book = book

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
    google_book = GoogleBooks.search("isbn:#{params[:advertisement_sale_book][:book][:isbn_13]}").first
    if google_book
      #On cherche si le livre est déja dans la bdd, si il l'est, on le met à jour, si il ne l'ai pas, onle crée
      book = Book.find_by_isbn_13(google_book.isbn_13) || Book.find_by_isbn_10(google_book.isbn_10) || Book.new(isbn_13: google_book.isbn_13, isbn_10: google_book.isbn_10)

      #On récupère tout les attribut dans le googlebook
      #@book.class.accessible_attributes.each do |attribute|
      #  unless attribute.blank?
      #    @book.attribute = @google_book.attribute
      #  end
      #end

      # mettre à jour book
      book.title = google_book.title
      book.description = google_book.description
      book.average_rating = google_book.average_rating
      book.ratings_count = google_book.ratings_count
      book.isbn_10 = google_book.isbn_10
      book.isbn_13 = google_book.isbn_13
      book.authors = google_book.authors
      book.language = google_book.language
      book.page_count = google_book.page_count
      # si c'est juste 2000, j'ajoute 2000-01-01
      if google_book.published_date.length == 4
        book.published_date = "#{google_book.published_date}-01-01".to_date
      else
        book.published_date = google_book.published_date
      end
      book.publisher = google_book.publisher
      book.image_link = google_book.image_link

=begin
      if google_book.image_link(:zoom => 2)
        book.image_link = google_book.image_link(:zoom => 2)
      elsif google_book.image_link(:zoom => 5)
        book.image_link = google_book.image_link(:zoom => 5)
      elsif google_book.image_link(:zoom => 1)
        book.image_link = google_book.image_link(:zoom => 1)
      else
        book.image_link = google_book.image_link(:zoom => 4)
      end
=end
      book.preview_link = google_book.preview_link
      book.info_link = google_book.info_link

    else
      # On crée le book avec le isbn entrée dans le formulaire
      book = Book.new(params[:advertisement_sale_book][:book])
    end

    # on enlève le book des parametres
    params[:advertisement_sale_book].delete(:book)
    # on crée le sale_book avec les parametres du form
    @advertisement_sale_book = Advertisement::SaleBook.new(params[:advertisement_sale_book])
    #On ajoute le livre dans la vente
    @advertisement_sale_book.book = book
    @advertisement_sale_book.user = current_user
    #
    respond_to do |format|
      if @advertisement_sale_book.save
        format.html { redirect_to @advertisement_sale_book, notice: t('sale_books.new.forms.succes') }
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
    # on enlève le book des parametres
    params[:advertisement_sale_book].delete(:book)
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])

    respond_to do |format|
      if @advertisement_sale_book.update_attributes(params[:advertisement_sale_book])
        format.html { redirect_to @advertisement_sale_book, notice: t('sale_books.edit.forms.succes') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisement_sale_book.errors, status: :unprocessable_entity }
      end
    end
  end

end
