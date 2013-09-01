# -*- encoding : utf-8 -*-
namespace :migrate_data do

  require 'Nokogiri'
  #le chemin global. Change si tes pas sur mon beau mac ;-)
  @dir = 'D:\Collaide\old\\'
  @upload = "#{@dir}uploads\\"  #deux \\ pour echaper le "

  # Ce fichier permet de lancer différentes tâches rake pour migrer de la version actuelle du site
  # à la nouvelle. Chaque tâche permet de migrer un type de donnée. Les noms sont explicites.
  # Pour l'utiliser, il faut avoir pour l'instant les exportations xml des tables :
  # * domains.xml
  # * membres.xml
  # * work_tabs.xml
  # Ces exportations doivent être dans un seul dossier.
  # Dans le même dossier, un dossier uploads qui contient tous les documents du site. Pour modifier
  # le chemin dans le quel se trouvent les dossiers, changer la variable @upload.
  # Pour modifier le répertoire de base où sont stoqués les fichiers xml, le faire à la ligne 5
  # Avant de vouloir migrer les documents, il faut exécuter les autres tâches.
  # Certains documents n'ont pas de descriptions. Pour l'instant, il faut modifier le fichier xml à la main,
  # environ 10 documents. A voir comment on veut le faire
  # D'autres documents n'ont pas de domaines, de type et/ou de degré d'étude. Il faut donc spécifier
  # des ids par défaut pour ces trois liaisons. Ce sont les variables ci-dessous.
  # Pour l'instant, tous les utilisateurs ont le mot de passe 'password'

  #adapter les variables en fonction de l'état de la bdd. Ce sont des ids
  @default_domain = 2
  @default_document_type = 2
  @default_study_level = 1
  @default_user = 1

  desc "Migrate the documents from the old version"
  task documents: :environment do
    I18n.locale = :fr
    puts 'strating migartion'
    xml_users = load_xml('membres.xml')
    xml_domains = load_xml('domains.xml')
    read_table('tab_works.xml', @dir, 'tab_works').each do |entry|
      #les données de base
      id = read_column('work_id', entry ).to_i
      title = read_column 'work_name', entry
      description = read_column 'work_desc', entry
      number_of_pages = read_column('work_pages', entry).to_i
      number_of_pages = 1 if number_of_pages<=0
      author = read_column 'work_autors', entry
      realized_at = Date.new(read_column('work_dateR', entry).to_i)
      created_at = read_column 'work_date', entry
      updated_at = read_column 'work_date_edit', entry
      hits = read_column 'work_hits', entry

      #petite manipulation pour le status nécessaire plus bas...
      status = read_column 'work_status', entry

      file_name = read_column 'doc_name_serv', entry
      original_file_name = read_column 'doc_name_serve', entry
      language = 'fr'
      is_deleted = read_column('work_statusM', entry) == 0 ? false: true

      #on crée les liaisons avec les users et les domaines
      id_user = read_column('work_autor', entry).to_i
      id_domain = read_column('work_domain', entry).to_i
      domain = find(xml_domains, id_domain, 'dom_id', 'dom_name', Domain) || Domain.find(@default_domain) #350 = les inclassables...
      user = find(xml_users, id_user, 'mem_ID', 'mem_pseudo', User)|| User.find(@default_user) #502 = pour moi !!!

      #les liaisons pour le tye et le niveau d'étude
      type = Document::Type.find_by_name(read_column('work_type', entry))||Document::Type.find(@default_document_type)
      study_level = Document::StudyLevel.find_by_name(read_column('work_degree', entry))||Document::StudyLevel.find(@default_study_level)

      #on cherche le bon fichier
      file_to_upload = File.open @upload+file_name

      document = Document::Document.new(
          title: title,
          description: description,
          author: author,
          realized_at: realized_at,
          hits: hits,
          language: language,
          is_deleted: is_deleted,
      )
      file_for_assoc = CFile::CFile.create(
         file: file_to_upload
      )
      puts "créé le doc : #{document.title} avec le fichier : #{file_for_assoc.file_file_name}"
      document.number_of_pages = number_of_pages
      case status
        when 0 then document.status = 'pending'
        when 1 then document.status = 'accepted'
        when -1 then document.status = 'refused'
      end

      document.domains<<domain
      document.study_level = study_level if study_level.present?
      document.document_type = type if type.present?
      document.user = user if user.present?
      document.files<<file_for_assoc
      document.save!

      document.created_at = created_at
      document.updated_at = DateTime.parse(updated_at) if updated_at!='0000-00-00 00:00:00'
      document.save
    end
  end

  desc "Migrate the users form the old version"
  task users: :environment do
    puts 'starting migration...'
    read_table('membres.xml', @dir, 'membres').each do |entry|
      name = read_column 'mem_pseudo', entry
      email = read_column 'mem_mail', entry
      password = 'password'
      created_at = read_column 'mem_date', entry
      last_sign_in_at = read_column 'mem_date_last', entry
      points = read_column 'mem_points', entry
      user = User.create(name: name, email: email, password: password, password_confirmation: password, points: points)
      user.created_at = created_at
      user.last_sign_in_at = last_sign_in_at
      user.save
    end
    puts 'all done.'
  end

  desc "Migrate the domains from the old table"
  task domains: :environment do
    I18n.locale = :fr
    puts 'generating the domains ...'
    file = File.open "#{@dir}domains.xml"
    xml_file = Nokogiri::XML file.read
    file.close
    read_table('domains.xml', @dir, 'domains').each do |entry|
      parent_id = read_column('dom_parent', entry).to_i
      name = read_column('dom_name', entry)
      description = read_column('dom_desc', entry)

      #on cherche son père. Bon, mnt il y a la méthode find qui le fait
      parent = nil
      xml_file.xpath("//column[@name='dom_id']").each do |node|
        parent = node if node.children.first.to_s.to_i == parent_id
      end
      parent_name = parent.xpath("../column[@name='dom_name']").children.first.to_s if parent.present?
      parent_sql = Domain.find_by_name parent_name

      #il a un père
      if parent_sql.present?
        parent_sql.children.create(name: name, description: description)
      #il est orphelin (root)
      else
        Domain.create!(name: name, description: description)
      end
    end
    puts 'all done.'
  end

  desc "Migrate the document types and the study levels form the old table document"
  task types_and_levels: :environment do
    #génère les types de documents et les niveaux d'études
    # le fait en français
    puts 'generating document types and study levels'
    I18n.locale = :fr
    types = []
    study_levels = []
    read_table('tab_works.xml', @dir, 'tab_works').each do |entry|
      type = read_column 'work_type', entry
      study_level = read_column 'work_degre', entry
      study_levels = collect_data study_level, study_levels
      types = collect_data type, types
    end
    types.each do |a_type|
      Document::Type.create(name: a_type, description: 'A compléter')
    end
    study_levels.each do |a_level|
      Document::StudyLevel.create(name: a_level, description: 'A compléter')
    end
    puts 'all done.'
  end

  desc "remove back-slash from documents"
  task back_slash: :environment do
    all = Document::Document.all
    all.each do |a_doc|
      a_doc.title = a_doc.title.tr("\\", '')
      a_doc.description = a_doc.description.tr('\\', '')
      a_doc.save
    end
  end

  # permet de trouver un champ dans la bdd en fonction d'une id spécifiée dans un fichier xml
  # xml_file: le fichier xml chargé avec Nokogiri. Utiliser la méthode load_xml
  # #equal_to à quoi doit être égale le champ de la table du fichier xml
  # #parent_id le nom du champ dans la table xml
  # #parent_name le nom du champ de la valeur à récupérer pour rechercher dans la bdd
  # #klass le model dans rails
  # #find_for_sql par quel type de champ aller chercher dans la table
  # utilisation:
  # #find(xml_user, 3, 'id', 'name', Document::Document) #=> dans le fichier xml,
  # va chercher le user avec l'id 3, prend la valeur du champ name et recherche un document dans la bdd
  # avec la valeur du champ name
  #@return nil si pas touvé un un model
  def find(xml_file, equal_to, parent_id, parent_name, klass, find_for_sql='name')
    parent = nil
    xml_file.xpath("//column[@name='#{parent_id}']").each do |node|
      parent = node if node.children.first.to_s.to_i == equal_to
      #puts "#{node.children.first.to_s.to_i} = #{equal_to} pour #{parent_name} -> #{parent.inspect}"
    end
    parent_name = parent.xpath("../column[@name='#{parent_name}']").children.first.to_s if parent.present?
    klass.send("find_by_#{find_for_sql}", parent_name)
  end

  # permet de lire une table.
  # utiliser la méthode each pour lire chaque ligne de la table.
  def read_table(file_name, path, table_name)
     file = File.open path+'/'+file_name
    xml = Nokogiri::XML file.read
    file.close
    xml.xpath("//table[@name='#{table_name}']")
  end

  # lit un champ spécifique à une ligne donnée pas l'attribut #node
  # xpat_expression n'est pas implémenté
  def read_column(column_name, node, xpath_expression='')
    node.xpath("column[@name='#{column_name}']").children.first.to_s
  end

  # Génére un tableau de hash pouvant être utilisé dans le fichier db/seed.rb
  # si on regarde ce fichier, on comprend
  def to_seed(values, klass='', field = 'name', more = "description: 'A compléter'")
    result = ''
     values.each do |value|
       result += "{#{field}: '#{value}', #{more}},\n"
     end
    result.chop.chop
  end

  # stoque les données dans le tableau passé en paramètre (output) seulement si elle n'y sont pas déjà.
  def collect_data(value, output)
    output<<value unless output.include? value
    output
  end

  # charge un fichier xml en mémoire avec Nokogiri
  def load_xml(file_name)
    file = File.open "#{@dir}#{file_name}"
    xml = Nokogiri::XML(file.read)
    file.close
    xml
  end
end