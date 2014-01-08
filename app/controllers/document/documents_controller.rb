# -*- encoding : utf-8 -*-
class Document::DocumentsController < ApplicationController
  load_and_authorize_resource class: Document::Document
  add_breadcrumb(I18n.t('document.documents.bc'), :document_documents_path)
  add_breadcrumb(I18n.t('document.documents.new.bc'), :new_document_document_path, only: [:new, :create])
  def create
    @document = Document::Document.new params[:document_document]
    @document.user = current_user
    if @document.save
      redirect_to document_documents_path, notice: t("document.documents.create.notice")
    else
      render action: 'new'
    end
  end

  # La page qui recommande de participer au site lorsqu'on a téléchargé un document
  def downloaded
    add_breadcrumb(I18n.t('document.documents.downloaded.bc'))
  end

  def new

    @document = Document::Document.new
    #@document.files.build
  end

  def index
    #TODO: optimisation des requêtes, déjà fait en partie. Possible de faire en core mieux ? a voir

    if params[:search].present?
      redirect_to search_document_documents_path(query: params[:search]) and return
    end

    # affichage suivant les critères de l'utilisateur
    title_a = []
    personalized_search = false
    sort = 'DESC'
    attr = 'document_documents.created_at'
    rates = ''
    order_by = params[:order_by].to_i
    case order_by
      when 1
        attr = 'document_documents.title'
        sort = 'ASC'
        personalized_search = true
      when 2
        rates = :note_average
        attr = 'rating_caches.avg'
        personalized_search = true
      when 3
        attr = 'document_documents.hits'
        personalized_search = true
    end
    where = ''
    joins = ''
    where_domains = ''
    domain = params[:domain] || params[:domain_id]
    type = params[:type] || params[:type_id]
    unless domain.blank?
      children_of_domain = Domain.subtree_of(domain).map { |a_domain| "domains.id=#{a_domain.id}" }.join(' OR ')
      where_domains = 'domains.id=:domain'
      where_domains << " OR #{children_of_domain}" if children_of_domain != where_domains and !children_of_domain.blank?
      joins = :domains
    end
    unless type.blank?
      where+= ' AND ' unless where.blank?
      where += 'document_documents.document_type_id=:type'
    end
    unless params[:created_at].blank?
      where+= ' AND ' unless where.blank?
      where+= 'document_documents.created_at >= :created_at'
      personalized_search = true
    end
    #la requête. Joli, non ?
     @document_documents = Document::Document.order("#{attr} #{sort}").
         includes([:study_level, :document_type, {domains: :translations}], :user, :files, :note_average).
         joins(joins).joins(rates).
         where(where, {domain: domain, type: type, created_at: params[:created_at]}).
         where(status: 'accepted').
         where(where_domains, {domain: domain}).
         page(params[:page])

    # définit l'url de la page et le titre en fonction des paramètres passés. C'est le bordel.
    # A voir si on peut mieux faire
    if domain.nil? and !type.nil?
      @url = type_document_documents_url(type)
      title_a << view_context.pluralize(@document_documents.size, Document::Type.find(type).name) if params[:order_by].nil? and params[:created_at].nil?
    elsif !domain.nil? and type.nil?
      @url = domain_document_documents_url(domain)
      title_a << t('document.documents.index.title_type', document: view_context.pluralize(@document_documents.size, t('document.documents.index.title_type_document')), domain: Domain.find(domain).name) if params[:order_by].nil? and params[:created_at].nil?
    elsif !domain.nil? and !type.nil?
      @url = domain_type_document_documents_url({type_id: type, domain_id: domain})
      title_a << t('document.documents.index.subtitle', domains: Domain.find(domain).name, type: view_context.pluralize(@document_documents.size, Document::Type.find(type).name)) if params[:order_by].nil? and params[:created_at].nil?
    elsif domain.nil? and type.nil?
      @url = document_documents_path
    end
    unless @url.nil?
      get_url_part=''
      get_url_part = "order_by=#{params[:order_by]}" unless params[:order_by].blank? or params[:order_by].to_s == '0'
      if !get_url_part.blank?
        if !params[:created_at].blank?
          get_url_part << "&created_at=#{params[:created_at]}"
        end
      end

      get_url_part = "created_at=#{params[:created_at]}" if get_url_part.blank? and !params[:created_at].blank?
      @url << "?#{get_url_part}" unless get_url_part.blank?
      logger.info "get_url_part=#{get_url_part.blank?} et created_at=#{params[:created_at].blank?}"
    end

    #pour la partie javascript. Si on est sur la page 1 ou une autre
    if params[:page].nil?
      @url_for_js = document_documents_url
    else
      @url_for_js = pager_document_documents_url(page: params[:page])
    end
    if personalized_search
      title_a = []
      title_a << t('document.documents.index.personlaized_search')
    end
    title_a << t('document.documents.index.page', nb_page: params[:page]) unless params[:page].nil?
    unless title_a.nil?
      content_for(:title, title_a.join(' - '))
      content_for(:key_words, t('document.documents.index.key_words') + ', ' + title_a.join(', '))
      content_for(:meta_description, t('document.documents.index.description_meta') + '. ' + title_a.map {|an_elem| "#{an_elem.titleize}"}.join('. '))
    end
    add_breadcrumb(title_a.join(' - ')) unless title_a.empty?
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
       redirect_to document_document_path(@document_documents), notice: t('document.documents.update.notice')
     else
       render 'edit'
     end

  end

  def destroy
    @document_documents = Document::Document.find params[:id]
    @document_documents.destroy()
    redirect_to document_documents_path, notice: t('document.documents.destroy.notice')
  end

  def show
     @document = Document::Document.find params[:id]
     add_breadcrumb(@document.title)
    @top_docs = {}
    Document::Document.all.each do |a_doc|
      unless a_doc.id == @document.id
        @top_docs[:hit] = a_doc if @top_docs[:hit].nil? or @top_docs[:hit].hits < a_doc.hits
        @top_docs[:created_at] = a_doc if @top_docs[:created_at].nil? or @top_docs[:created_at].created_at < a_doc.created_at
        @top_docs[:notest] = a_doc if !a_doc.note_average.nil? and(@top_docs[:notest].nil? or @top_docs[:notest].note_average.avg < a_doc.note_average.avg)
      end
    end

    @suggest = []
    Document::Document.joins(:domains).where("domains.id=#{@document.domains.first.id}").all.each do |a_doc|
      @suggest << a_doc if a_doc.id != @document.id and @suggest.size <3
    end
    content_for(:title, t('document.documents.show.meta_title',
                         doc_name: @document.title,
                         title_type: t('document.documents.index.title_type',
                                       document: @document.document_type.name,
                                       domain: @document.domains.first.name)))
    key_words = []
    key_words << @document.title
    key_words << @document.document_type.name
    key_words << @document.study_level.name
    @document.domains.each {|a_domain| key_words << a_domain.name}
    key_words << t('dico.download')
    key_words << t('dico.free')
    content_for(:key_words, key_words.join(', '))
    content_for(:meta_description, @document.description)
  end

  def download
    #méthode d'envoi de fichier :default -> pour le local
    send_file_method = :default
    #recherche du document
    doc = Document::Document.find(params[:document_document_id])
    raise ActiveRecord::RecordNotFound  and return if (doc.nil?)

    #le document a-t-il déjà été téléchargé par l'utilisateur ?
    download =  Document::Download.where(document_documents_id: doc.id).where(user_id: current_user.id)
    if download.empty?
      # si l'utilisateur n'a plus assez de points, que ce n'est pas un document qu'il a déposé et qu'il n'a pas encore
      # été averti, on redirige et on arrête
      if current_user.points-Point::DOWNLOAD_DOCUMENT<=0 and doc.user.id != current_user.id and !params[:try].nil? and params[:try] != 'true'
        redirect_to no_credit_users_path, alert: t('document.documents.download.no_credit', doc_name: doc.title) and return
      else
        # on lui enlève le bon nombre de points si ce n'est pas un de ses documents
        unless doc.user.id == current_user.id
          current_user.points = current_user.points-Point::DOWNLOAD_DOCUMENT
          current_user.save
        end
      end
      # l'utilisateur n'a jamais téléchargé ce document.
      # On créée un nouveau modèle qui enregistre le nombre de téléchargement pour chaque document
      doc_download = Document::Download.new
      doc_download.number_of_downloads=1
      doc_download.document = doc
      doc_download.user = current_user
      doc_download.save
    # l'utilisateur a téléchargé au moins une fois ce document
    else
      # la requête renvoi un tableau de taille 1. On a donc besoin de prendre le premier
      download.first.number_of_downloads++1
      download.first.save
    end

    # le chemin du fichier à télécharger. Pour l'instant, un fichier par document -> le premier
    path = doc.files.first.file.path

    # Si le fichier n'est pas trouvé
    render status: :bad_request and return unless File.exist?(path)

    send_file_options = { :type => MIME::Types.type_for(path).first.content_type, disposition: :inline }

    case send_file_method
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end

    # on envoie le fichier
    send_file(path, send_file_options)
    doc.hits = doc.hits+1
    doc.save
  end

  def search
    @document_documents = Document::Document.search(
        Riddle::Query.escape(params[:query]),
        page: params[:page],
        ranker: :bm25,
        field_weights: {
          title: 10,
          domains: 10,
          document_type: 7,
          study_level: 5,
          user: 5,
          author: 6,
          description: 1
        }
    )
    @searched_value = params[:query]
    content_for(:title, t('document.documents.index.search', search: @searched_value))
    add_breadcrumb(t('document.documents.index.search', search: @searched_value))
    respond_to do |format|
      format.js {render 'document/documents/index.js'}
      format.html {render 'document/documents/index.html'}
    end
  end

  def autocomplete
    res =  Document::Document.search(
        Riddle::Query.escape(
            params[:term]),
            rank: :fieldmask,
            field_weights: {
                title: 10,
                domains: 8,
                document_type: 7,
                study_level: 5,
                user: 5,
                author: 6,
                description: 2
            }
    ).map do |a_res|
       {id: a_res.id, value: a_res.title}
    end
    respond_to do |format|
      format.js { render json: res }
    end
  end
end
