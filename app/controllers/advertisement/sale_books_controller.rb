# -*- encoding : utf-8 -*-
class Advertisement::SaleBooksController < ApplicationController
  load_and_authorize_resource class: Advertisement::SaleBook

  include BooksHelper, Concerns::ActivityConcern

  #breadcrumb
  add_breadcrumb I18n.t("advertisements.index.breadcrumb"),  :advertisement_advertisements_path
  #TODO faire une page qui affiche que les livres
  #add_breadcrumb I18n.t(""),  :advertisement_sale_books_path

  add_breadcrumb I18n.t("advertisements.new.title"), :new_advertisement_advertisement_path, :only => %w(new create)
  add_breadcrumb I18n.t("sale_books.new.title_page"), :new_advertisement_sale_book_path, :only => %w(new create)

  # GET /advertisement/sale_books/1
  # GET /advertisement/sale_books/1.json
  def show
    @message = UserMessage.new

    @sale_book = Advertisement::SaleBook.find(params[:id])
    @message.users << @sale_book.user
    @message.subject=t('sale_books.buy.subject', book: @sale_book.book.title)
    @message.body=t('sale_books.buy.textarea', book: @sale_book.book.title)

    add_breadcrumb I18n.t("sale_books.show.title", book: @sale_book.book.title), advertisement_sale_book_path(@sale_book)
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
      format.json {
        isbn = params[:isbn]
        parse_isbn(isbn)
        logger.debug(isbn.inspect)
        google_book = GoogleBooks.search("isbn:#{isbn}", {}, request.remote_ip).first
        logger.debug(GoogleBooks.search("isbn:#{isbn}", {}, request.remote_ip))
        logger.debug(google_book.inspect)
        if google_book && !isbn.blank?
          logger.debug('Here we fill the book with the google infos')
          fillBook(@advertisement_sale_book.book, google_book)
        end
        render json: @advertisement_sale_book.book
      }
    end
  end

  # GET /advertisement/sale_books/1/edit
  def edit
    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])
    add_breadcrumb I18n.t("sale_books.show.title", book: @advertisement_sale_book.book.title), advertisement_sale_book_path(@advertisement_sale_book)
    add_breadcrumb I18n.t("sale_books.edit.title", book: @advertisement_sale_book.book.title), edit_advertisement_sale_book_path(@advertisement_sale_book)

    #content_for(:key_words, t('document.documents.index.key_words') + ', ' + title_a.join(', '))
    #content_for(:meta_description, t('document.documents.index.description_meta') + '. ' + title_a.map {|an_elem| "#{an_elem.titleize}"}.join('. '))

  end

  # POST /advertisement/sale_books
  # POST /advertisement/sale_books.json
  def create
    # ON CHERCHE SUR LE ISBN CORRESPOND
    isbn = book_params[:isbn_13]
    parse_isbn(isbn)
    google_book = GoogleBooks.search("isbn:#{isbn}", {}, request.remote_ip).first

    if google_book && !isbn.empty?
      #On cherche si le livre est déja dans la bdd, si il l'est, on le met à jour, si il ne l'ai pas, onle crée
      book = Book.find_by(isbn_13: google_book.isbn_13) || Book.find_by(isbn_10: google_book.isbn_10) || Book.new(isbn_13: google_book.isbn_13, isbn_10: google_book.isbn_10)

      fillBook(book, google_book)
    else
      # Si il a entré un faux isbn, je met un espace a autheur pour voir qu'il a entré quelque chose
      if params[:book][:title] && params[:book][:authors]
        if !params[:book][:title].empty? && !params[:book][:authors].empty?
          params[:book][:isbn_13] = ''
        end
      end
      # On crée le book avec le isbn entrée dans le formulaire
      book = Book.new(book_params)
    end

    # on enlève le book des parametres
    #params[:advertisement_sale_book].delete(:book)
    # on crée le sale_book avec les parametres du form
    @advertisement_sale_book = Advertisement::SaleBook.new(advertisement_sale_book_params)
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

  # sert à remplir le book avec les infos de google book
  def fillBook(book, google_book)

    # mettre à jour book
    book.title = google_book.title
    book.description = google_book.description
    book.average_rating = google_book.average_rating
    book.ratings_count = google_book.ratings_count
    book.isbn_10 = google_book.isbn_10
    book.isbn_13 = google_book.isbn_13
    book.authors = google_book.authors
    book.authors = book_params[:authors] if google_book.authors.empty?
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
  end

  # PUT /advertisement/sale_books/1
  # PUT /advertisement/sale_books/1.json
  def update
    # on enlève le book des parametres
    #params[:advertisement_sale_book].delete(:book)

    @advertisement_sale_book = Advertisement::SaleBook.find(params[:id])

    respond_to do |format|
      if @advertisement_sale_book.update_attributes(params[:advertisement_sale_book])
        format.html { redirect_to @advertisement_sale_book, notice: t('sale_books.edit.forms.succes') }
        format.json { head :no_content }
      else
        add_breadcrumb I18n.t("sale_books.show.title", book: @advertisement_sale_book.book.title), advertisement_sale_book_path(@advertisement_sale_book)
        add_breadcrumb I18n.t("sale_books.edit.title", book: @advertisement_sale_book.book.title), edit_advertisement_sale_book_path(@advertisement_sale_book)
        format.html { render action: "edit" }
        format.json { render json: @advertisement_sale_book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def advertisement_sale_book_params
    params[:book] = book_params
    params.require(:advertisement_sale_book).permit(
        :price, :currency, :state, :annotation, :description, :study_level, domain_ids: [], payment_modes: [], delivery_modes: []
    )
  end

  def book_params
    # params.require(:advertisement_sale_book).permit(
    #     :price, :currency, :payment_modes, :delivery_modes, :state,
    #     :annotation, :title, :description, :domain_ids, :study_level,
    #     book: [:isbn_13, :authors]
    # )
    @book_params ||= params.require(:advertisement_sale_book).permit(book: [:isbn_13, :title, :authors])[:book]
    #@book_params ||= params.require(:advertisement_sale_book).permit(book: :isbn_13, book: :title, book: :authors)
  end
end
