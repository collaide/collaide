# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisement_advertisements
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  active         :boolean
#  type           :string(255)
#  user_id        :integer
#  book_id        :integer
#  language       :string(255)
#  hits           :integer
#  price          :decimal(9, 2)
#  currency       :string(255)
#  delivery_modes :string(255)
#  payment_modes  :string(255)
#  state          :string(255)
#  annotation     :string(255)
#  study_level    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  extend Enumerize
  enumerize :annotation, in: [:not_annotated, :slightly_annotated, :annotated, :very_annotated]
  enumerize :state, in: [:new, :like_new, :normal, :damaged, :very_damaged]
  include Concerns::StudyLevel
  enumerize_study_level

  #Liaisons
  belongs_to :book
  has_and_belongs_to_many :domains, class_name: 'Domain'#TODO check si on peut enlever, order: 'position ASC'

  accepts_nested_attributes_for :domains
  accepts_nested_attributes_for :book

  before_validation :add_title

  private

    #Add a default title to the advertisement
    def add_title
      self.title = I18n.t'sale_books.show.sale_title',  book: book.title if title.blank?
    end

end
