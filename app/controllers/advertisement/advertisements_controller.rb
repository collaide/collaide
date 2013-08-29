class Advertisement::AdvertisementsController < ApplicationController
  load_and_authorize_resource class: Advertisement::Advertisement

  # Copier/coller de documents_controller.rb
  def create
    @advertisement = Advertisement::Advertisement.new params[:advertisement_advertisement]
    @advertisement.user = current_user
    if @advertisement.save
      redirect_to advertisement_advertisements_path, notice: t("advertisement.create.notice")
    else
      render action: 'new'
    end
  end

  def new
    #Il n'y a pas de création de nouvea advertisements, car c'est un object abstrait qui doit être hérité (par SaleBook, par ex)
    # La page new propose donc ce que le user veut créer
  end

  def newSaleBook
    isbn = 'isbn:9781443411080'
    @book = GoogleBooks.search(isbn).first
    @bookSale = Advertisement::SaleBook.new
  end

  def index
    @advertisement = Advertisement::Advertisement.all

  end

  def edit
    @advertisement = Advertisement::Advertisement.find params[:id]
  end

  def update
    @advertisement = Advertisement::Advertisement.find(params[:id])
    if @advertisement.update_attributes(params[:advertisement_advertisement])
      redirect_to advertisement_advertisements_path(@advertisement), notice: t('advertisement.update.notice')
    else
      render 'edit'
    end

  end

  def destroy
    @advertisement = Advertisement::Advertisement.find params[:id]
    @advertisement.destroy()
    redirect_to advertisement_advertisements_path, notice: t('advertisement.destroy.notice')
  end

  def show
    @advertisement = Advertisement::Advertisement.find params[:id]
  end

  def test
    @books = GoogleBooks.search('The Great Gatsby')
    #@first_book = books.first


    #first_book.author #=> 'F. Scott Fitzgerald'
    #first_book.isbn #=> '9781443411080'
    #first_book.image_link(:zoom => 6) #=> 'http://bks2.books.google.com/books?id=...'
  end
end
