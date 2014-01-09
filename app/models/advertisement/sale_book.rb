# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisement_advertisements
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  active      :boolean
#  type        :string(255)
#  price       :decimal(9, 2)
#  currency    :string(255)
#  state       :string(255)
#  annotation  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  language    :string(255)
#  book_id     :integer
#  hits        :integer          default(0)
#

# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  attr_accessible :state, :annotation, :domain_ids, :study_level_id

  extend Enumerize
  enumerize :annotation, in: [:not_annotated, :slightly_annotated, :annotated, :very_annotated]
  enumerize :state, in: [:new, :like_new, :normal, :damaged, :very_damaged]

  #Liaisons
  belongs_to :book
  has_and_belongs_to_many :domains, order: 'position ASC'
  belongs_to :study_level, :class_name => 'Document::StudyLevel', include: :translations

  accepts_nested_attributes_for :domains
  accepts_nested_attributes_for :book

  before_validation :add_title

  private

    #Add a default title to the advertisement
    def add_title
      self.title = t'sale_books.show.sale_title',  book: book.title if title.blank?
    end

end
