# -*- encoding : utf-8 -*-
class Document::DocumentsController < ApplicationController
  load_and_authorize_resource class: Document::Document
  def create
    puts 'saluttzo '
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
    sort = 'DESC'
    sort = 'ASC' if params[:order] == 'asc'
    attr = Document::Document::SORT_ARGS[:"#{params[:sort].to_s}"] || 'document_documents.created_at'

     @document_documents = Document::Document.order("#{attr} #{sort}").
         includes([:study_level, :document_type, {domains: :translations}]).
         page(params[:page])
    #TODO: Comment afficher les documents par domaines ?
    #unless params[:domain].nil?
    #  where_domains = {:"domains.name" => params[:domain]}
    #  @document_documents.where(where_domains)
    #end

    respond_to do |format|
      format.html # index.html.haml
      format.json do
        urls = {}
        dates = {}
        domains = {}
        @document_documents.each do |doc|
          dates[:"#{doc.id.to_s}"] = l(doc.created_at, format: :long)
          urls[:"#{doc.id.to_s}"] = document_document_path(doc.id)
          domains[:"#{doc.id.to_s}"] = Domain.flat(doc.domains)
        end
        render json: {doc: @document_documents, dates: dates, urls: urls, domains: domains}.to_json(methods: [:study_level, :document_type, :domains])
      end
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
