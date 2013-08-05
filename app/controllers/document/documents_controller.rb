class Document::DocumentsController < InheritedResources::Base

  def create
    document = Document::Document.new params[:document_document]
    if document.save
      redirect_to document_documents_url
    else
      render action: 'new'
    end
  end

  def new
    @document = Document::Document.new
  end
end
