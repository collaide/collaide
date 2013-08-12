# == Schema Information
#
# Table name: c_file_owners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  rights     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
#pas utilisé pour le moment. Un utilisateur a les droits sur le fichier, pour autant qu'il soit dans son répertoire
class CFile::Owner < ActiveRecord::Base
  attr_accessible :name, :rights
end
