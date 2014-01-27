# -*- encoding : utf-8 -*-
class Advertisement::GroupsController < ApplicationController
  load_and_authorize_resource class: Advertisement::Advertisement

  #breadcrumb
  add_breadcrumb I18n.t("advertisements.index.breadcrumb"),  :advertisement_advertisements_path

  def new
    add_breadcrumb I18n.t("advertisements.new.title"), :new_advertisement_advertisement_path
    #Il n'y a pas de création de nouvea groups, car c'est un object abstrait qui doit être hérité (par SaleBook, par ex)
    # La page new propose donc ce que le user veut créer
    redirect_to :new_advertisement_sale_book
  end

  def index
    #@message = UserMessage.new
    # Pour changer le nombre d'éléments par page, ajouter .per(5) après la méthode page
    @advertisement = Advertisement::Advertisement.order('created_at DESC').includes(:user, {book: :note_average}).page(params[:page])
  end

  def search
    @message = UserMessage.new
    @advertisement = Advertisement::SaleBook.search(
        Riddle::Query.escape(params[:search])
    )
    @searched_value=params[:search]
    render 'advertisement/groups/index'
  end

  def autocomplete
    res =  Advertisement::SaleBook.search(
        Riddle::Query.escape(params[:term])
    ).map do |a_res|
      {id: a_res.id, value: a_res.book.title}
    end
    respond_to do |format|
      format.js { render json: res }
    end
  end

  def destroy
    @advertisement = Advertisement::Advertisement.find params[:id]
    @advertisement.destroy()
    redirect_to advertisement_advertisements_path, notice: t('advertisement.destroy.notice')
  end

  include BooksHelper
  def test
    isbn = "3.2_34-23 2-323 2-232"

    parse_isbn(isbn)
    @salut= isbn
    @books = GoogleBooks.search("isbn:#{@salut}")
  end
end
