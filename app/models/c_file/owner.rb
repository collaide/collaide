#pas utilisé pour le moment. Un utilisateur a les droits sur le fichier, pour autant qu'il soit dans son répertoire
class CFile::Owner < ActiveRecord::Base
  attr_accessible :name, :rights
end
