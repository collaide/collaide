# -*- encoding : utf-8 -*-
class Document::StudyLevelsController < InheritedResources::Base
  load_and_authorize_resource class: Document::StudyLevel
end
