# -*- encoding : utf-8 -*-
class GuestBooksController < ApplicationController
  load_and_authorize_resource
  #before_action :guest_book_create_params, only: [:create]
  # GET /guest_books
  # GET /guest_books.json
  def index
    @guest_books = GuestBook.order('created_at DESC').page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guest_books }
      format.xml { render xml: @guest_books}
    end
  end

  # GET /guest_books/1
  # GET /guest_books/1.json
  def show
    @guest_book = GuestBook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest_book }
      format.xml { render xml: @guest_book}
    end
  end

  # GET /guest_books/new
  # GET /guest_books/new.json
  def new
    @guest_book = GuestBook.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @guest_book }
      format.xml { render xml: @guest_book }
    end
  end

  # POST /guest_books
  # POST /guest_books.json
  def create
    @guest_book = GuestBook.new(name: guest_book_params[:name], comment: guest_book_params[:comment])

    respond_to do |format|
      if @guest_book.save
        format.html { redirect_to @guest_book, notice: t("guest_books.create.notice") }
        format.json { render json: @guest_book, status: :created, location: @guest_book }
      else
        format.html { render action: "new" }
        format.json { render json: @guest_book.errors, status: :unprocessable_entity }
        format.xml { render xml: @guest_book.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def guest_book_params
    params.require(:guest_book).permit(:name, :comment)
  end
end
