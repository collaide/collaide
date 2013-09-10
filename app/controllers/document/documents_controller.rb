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

    if params[:search].present?
      redirect_to search_document_documents_path(query: params[:search]) and return
    end

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
        rates = :note_average
        attr = 'rating_caches.avg'
      when 3
        attr = 'document_documents.hits'
    end
    where = ''
    joins = ''
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
    @top_docs = {}
    Document::Document.all.map do |a_doc|
      unless a_doc.id == @document.id
        @top_docs[:hit] = a_doc if @top_docs[:hit].nil? or @top_docs[:hit].hits<a_doc.hits
        @top_docs[:created_at] = a_doc if @top_docs[:created_at].nil? or @top_docs[:created_at].created_at<a_doc.created_at
        @top_docs[:notest] = a_doc if !a_doc.note_average.nil? and(@top_docs[:notest].nil? or @top_docs[:notest].note_average.avg < a_doc.note_average.avg)
      end
    end

    @suggest = []
    Document::Document.joins(:domains).where("domains.id=#{@document.domains.first.id}").all.each do |a_doc|
      @suggest << a_doc if a_doc.id != @document.id and @suggest.size <3
    end
  end

  def download
    send_file_method = :default
    doc = Document::Document.find(params[:document_document_id])
    head(:not_found) and return if (doc.nil?)

    download =  Document::Download.where(document_documents_id: doc.id).where(user_id: current_user.id)
    if download.empty?
      if current_user.points-Point::DOWNLOAD_DOCUMENT<=0
        redirect_to no_credit_users_path, alert: t('documents.download.no_credit', doc_name: doc.title) and return
      end
      current_user.points = current_user.points-Point::DOWNLOAD_DOCUMENT
      current_user.save
      doc_download = Document::Download.new
      doc_download.number_of_downloads=1
      doc_download.document = doc
      doc_download.user = current_user
      doc_download.save
    else
      download.first.number_of_downloads++1
      download.first.save
    end

    path = doc.files.first.file.path

    head(:bad_request) and return unless File.exist?(path)

    send_file_options = { :type => MIME::Types.type_for(path).first.content_type, disposition: :inline }

    case send_file_method
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end

    send_file(path, send_file_options)
    doc.hits = doc.hits+1
    doc.save
  end

  def search
    @document_documents = Document::Document.search(Riddle::Query.escape(params[:query]), page: params[:page], ranker: :bm25)
    @searched_value = params[:query]
    respond_to do |format|
      format.js {render 'document/documents/index.js'}
      format.html {render 'document/documents/index.html'}
    end
  end

  def autocomplete
    res =  Document::Document.search(Riddle::Query.escape(params[:term])).map do |a_res|
       {id: a_res.id, value: a_res.title}
    end
    respond_to do |format|
      format.js { render json: res }
    end
  end
end
