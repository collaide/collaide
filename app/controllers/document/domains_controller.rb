class Document::DomainsController < ApplicationController
  load_and_authorize_resource
  def show
    @domain = Domain.find params[:id]
  end

  def index
    @domains = Domain.arrange(order: :position)
  end
end
