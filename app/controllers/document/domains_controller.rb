# -*- encoding : utf-8 -*-
class Document::DomainsController < ApplicationController
  #load_and_authorize_resource class: Document::Domain
  def show
    @domain = Domain.find params[:id]
  end

  def index
    @domains = Domain.arrange(order: :position)
  end

  def json_tree
    render json: Domain.json_tree(Domain.includes(:translations).arrange(order: :position)).to_json
  end
end
