class Advertisement::Sale_book < Advertisement::Sale
  attr_accessible :state, :annotation

  has_and_belongs_to_many :domains, order: 'position ASC'
end
