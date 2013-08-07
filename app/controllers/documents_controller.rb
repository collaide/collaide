class DocumentsController < InheritedResources::Base

  def create
    @document = Document::Document.new params[:document_document]
    if @document.save
      redirect_to document_path(@document)
    else
      @document.files.build
      render action: 'new'
    end
  end

  def new
    @document = Document::Document.new
    @document.author = current_user.name_to_show
    @document.files.build
  end

  def index
    #TODO Order by, comment le passer en paramètre ?
    #TODO optimisation des requêtes, possibles de diminuer de beaucoup si on cherche dans la doc -> configuration du modèle
     @document_documents = Document::Document.order('created_at DESC').page(params[:page])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def show
     @document = Document::Document.find params[:id]
  end
end
