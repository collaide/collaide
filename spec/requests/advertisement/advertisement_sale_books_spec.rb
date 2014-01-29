# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Advertisement::SaleBooks" do
  describe "visit the books" do
    it "renders an empty list" do
      visit(advertisement_advertisements_path)
      page.should have_content('Il n\'y a aucune annonce')
    end
    it 'renders a non empty list' do
      sb = FactoryGirl.create(:sale_book)
      sb.user = FactoryGirl.create(:user)
      sb.save
      visit(advertisement_advertisements_path)
      page.should have_content(sb.title)
    end
    describe 'sell a new book'  do
      it 'redirect when a no connected user want to sell a book' do
        get('fr/annonce/livres/nouveau')
        response.status.should eq(302)
      end
      it 'render a new form for selling a book' do
        sign_in_as_a_valid_user
        get('fr/annonce/livres/nouveau')
        expect(response).to render_template(:new)
      end
      it 'post a new book for selling' do
        sign_in_as_a_valid_user
        post '/fr/annonce/livres', advertisement_sale_book:
            {book: {isbn_13: 0, title: 'numa', authors: 'moi'},
            price: 12, currency: 'EUR'}
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end

  end
end
