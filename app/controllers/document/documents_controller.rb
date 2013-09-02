# -*- encoding : utf-8 -*-
class Document::DocumentsController < ApplicationController
  load_and_authorize_resource class: Document::Document
  def create
    @document = Document::Document.new params[:document_document]
    @document.user = current_user
    if @document.save!
      redirect_to document_documents_path, notice: t("documents.create.notice")
    else
      render action: 'new'
    end
  end

  def new
    @document = Document::Document.new
    @document.author = current_user.name_to_show
    #@document.files.build
  end

  def index
    #TODO optimisation des requêtes, déjà fait en partie. Possible de faire en core mieux ? a voir

    # affichage suivant les critères de l'utilisateur
    sort = 'DESC'
    attr = 'document_documents.created_at'
    rates = ''
    order_by = params[:order_by].to_i
    case order_by
      when 1
        attr = 'document_documents.title'
        sort = 'ASC'
      when 2
        rates = :rate_average_without_dimension
        attr = 'rating_caches.avg'
      when 3
        attr = 'document_documents.hits'
    end
    where = ''
    joins = ''
    logger.info params.inspect
    domain = params[:domain] || params[:domain_id]
    type = params[:type] || params[:type_id]
    unless domain.blank?
      where = 'domains.id=:domain'
      joins = :domains
    end
    unless type.blank?
      where+= ' AND ' unless where.blank?
      where += 'document_documents.document_type_id=:type'
    end
    unless params[:created_at].blank?
      where+= ' AND ' unless where.blank?
      where+= 'document_documents.created_at <= :created_at'
    end


    if params[:order_by].nil? and params[:created_at].nil?
        if domain.nil? and !type.nil?
          @url = type_document_documents_url(type)
        elsif !domain.nil? and type.nil?
          @url = domain_document_documents_url(domain)
        elsif !domain.nil? and !type.nil?
          @url = domain_type_document_documents_url({type_id: type, domain_id: domain})
        end
    end

    #la requête. Joli, non ?
     @document_documents = Document::Document.order("#{attr} #{sort}").
         includes([:study_level, :document_type, {domains: :translations}]).
         joins(joins).joins(rates).
         where(where, {domain: domain, type: type, created_at: params[:created_at]}).
         page(params[:page])
    #pour la partie javascript. Si on est sur la page 1 ou une autre
    if params[:page].nil?
      @url_for_js = document_documents_url
    else
      @url_for_js = pager_document_documents_url(page: params[:page])
    end

    respond_to do |format|
      format.html # index.html.haml
      format.js # index.js.haml
    end
  end

  def edit
     @document = Document::Document.find params[:id]
  end

  def update
    @document_documents = Document::Document.find(params[:id])
     if @document_documents.update_attributes(params[:document_document])
       redirect_to document_document_path(@document_documents), notice: t('documents.update.notice')
     else
       render 'edit'
     end

  end

  def destroy
    @document_documents = Document::Document.find params[:id]
    @document_documents.destroy()
    redirect_to document_documents_path, notice: t('documents.destroy.notice')
  end

  def show
     @document = Document::Document.find params[:id]
  end
end
