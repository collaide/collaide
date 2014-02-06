# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  authors        :string(255)
#  publisher      :string(255)
#  published_date :date
#  description    :text
#  isbn_10        :string(255)
#  isbn_13        :string(255)
#  page_count     :integer
#  average_rating :float
#  ratings_count  :integer
#  language       :string(255)
#  preview_link   :string(255)
#  info_link      :string(255)
#  image_link     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Book do
  context 'instantiation' do
    it 'creates a book' do
      book = FactoryGirl.create(:book)
      book.reload.should eq(book)
    end
  end
  context 'association' do
    it 'has many sale books' do
      book = FactoryGirl.build(:book)
      book.sale_books << FactoryGirl.create(:sale_book)
      sb = book.sale_books << FactoryGirl.create(:sale_book)
      book.save
      book.reload.sale_books.should eq(sb)
    end
    it 'has a note' do
      book = FactoryGirl.create(:book)
      book.rate(2, FactoryGirl.build(:user))
      book.save
      b2 = Book.includes(:note_average).find(book.id)
      b2.average.avg.should eq(2.0)
    end
  end
end
