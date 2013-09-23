# -*- encoding : utf-8 -*-
module Document::DocumentsHelper

  def languages_list
    #TODO: Compléter la liste
    [[t("translation.en"), :en], [t("translation.fr"), :fr]]
  end

  # Print links for sorting documents (ascendant or descendant) by a specified attribute
  #
  # By default it's a link for using ajax. The terms 'asc' for ascendant and 'desc' for descendant are used.
  # The parameters 'sort' (indicates with which attribute to sort) and 'order' (desc or asc) are passed via GET
  # The 'order' parameter have two possibilities: 'asc' or 'desc'
  # You can pass following options:
  # :remote if false that's default links
  # :asc text for the link for ordering by ASC
  # :desc text for the link for ordering by DESC
  # :only To specify only one of the two links
  def order_by(attribute, options = {})
    raise Exception.new("Options for has_ancestry must be in a hash.") unless options.is_a? Hash
    options.each do |key, value|
      unless [:remote, :asc, :desc, :only].include? key
        raise Exception.new("Unknown option for DocumentsHelper#order_by: #{key.inspect} => #{value.inspect}.")
      end
    end
    remote = true
    remote = false if options[:remote] == false
    asc = options[:asc] || 'asc'
    desc = options[:desc] || 'desc'
    links = ""
    links = "#{link_to(asc, document_documents_path(sort: attribute, order: 'asc', page: params[:page], format: :json), remote: remote)}" unless options[:only] == :asc
    links+=" / #{link_to(desc, document_documents_path(sort: attribute, order: 'desc', page: params[:page], format: :json), remote: remote)}" unless options[:only] == :desc
    raw links
  end

  def domain_breadcrumb (domains, sep=',')
    name = ""
    domains.map.with_index do |a_domain, key|
      sep = " #{I18n.translate('dico.and')} " if domains.size >=2 and key+2 == domains.size
      name += "#{link_to a_domain.name document_domain_path(a_domain)}#{sep} "
    end
    raw name.chop.chop
  end

  def show_icon(document)
    paperclip = document.files.first.file_content_type
    #FIXME: aucune image pour les doc en .txt
    "documents/#{find_extension(paperclip).to_s}.png"
  end

  def find_extension(application_type)
    doc_types = {
        image: %w(image/jpg image/jpeg image/pjpeg image/png image/x-png image/gif),
        pdf: %w(application/pdf),
        doc: %w(application/msword applicationvnd.ms-word applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document),
        docx: %w[application/vnd.openxmlformats-officedocument.wordprocessingml.document],
        xls: %w(application/msexcel application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet),
        ppt: %w(application/mspowerpoint application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml.presentation),
        txt: %w(text/plain)
    }
    doc_types.each do |type, array|
      if array.include?(application_type)
        return type
      end
    end
    'unknow'
  end

  def doc_sub_title(document)
    raw t('document.documents.index.subtitle',
          {type: link_to(document.document_type.name, type_document_documents_path(document.document_type)),
           domains: link_to(document.domains.first.name, domain_document_documents_path(document.domains.first))})
  end
end
