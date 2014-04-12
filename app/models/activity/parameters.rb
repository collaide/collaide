class Activity::Parameters < ActiveRecord::Base
  attr_accessor :type, :id_type

  before_save :encode_condition

  def initialize(params = {})
    @type = params[:type]
    @id_type = params[:id_type]
    super(params)
  end

  validates :type, presence: true
  validates :id_type, presence: true

  def encode_condition

  end
end
