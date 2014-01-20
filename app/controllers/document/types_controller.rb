# -*- encoding : utf-8 -*-
class Document::TypesController < InheritedResources::Base
  load_and_authorize_resource class: Document::Type
end
