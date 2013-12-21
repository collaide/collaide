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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Book do
  pending "add some examples to (or delete) #{__FILE__}"
end
