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