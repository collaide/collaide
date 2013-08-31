namespace :migrate_data do

  require 'Nokogiri'
  @dir = '/Users/leo/Downloads'

  desc "Migrate the documents from the old version"
  task documents: :environment do
    I18n.locale = :fr
    puts 'strating migartion'
    xml_users = load_xml('membres.xml')
    xml_domains = load_xml('domains.xml')
    read_table('tab_works.xml', @dir, 'tab_works').each do |entry|
      id = read_column('work_id', entry ).to_i
      title = read_column 'work_name', entry
      description = read_column 'work_desc', entry
      number_of_pages = read_column 'work_pages', entry
      author = read_column 'work_autors', entry
      realized_at = Date.new(read_column('work_dateR', entry).to_i)
      created_at = read_column 'work_date', entry
      update_at = read_column 'work_date_edit', entry
      hits = read_column 'work_hits', entry
      status = read_column 'work_status', entry
      file_name = read_column 'doc_name_serv', entry
      original_file_name = read_column 'doc_name_serve', entry
      language = 'fr'
      is_deleted = read_column('work_statusM', entry) == 0 ? false: true
      id_user = read_column 'work_autor', entry
      domain = find(xml_domains, id, 'dom_id', 'dom_name', Domain)
      user = find(xml_users, id_user, 'mem_ID', 'mem_pseudo', User)
      type = Document::Type.find_by_name(read_column('work_type', entry))
      study_level = Document::StudyLevel.find_by_name(read_column('work_degree', entry))
      file_to_upload = File.open @dir+'/'+file_name
      document = Document::Document.create(
          title: title,
          description: description,
          number_of_pages: number_of_pages,
          author: author,
          realized_at: realized_at,
          hits: hits,
          status: status,
          language: language,
          is_deleted: is_deleted,
      )
      file_for_assoc = CFile::CFile.create(
         file: file_to_upload
      )
      file_for_assoc.file_file_name = original_file_name
      file_for_assoc.save
      document.created_at = created_at
      document.updated_at = DateTime.parse(update_at) if updated_at!='0000-00-00 00:00:00'
      document.domains<<domain
      document.study_level = study_level if study_level.present?
      document.document_type = type if type.present?
      document.user = user if user.present?
      document.files<<file_for_assoc
      document.save
    end
  end

  desc "Migrate the user form the old version"
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
    file = File.open "#{@dir}/domains.xml"
    xml_file = Nokogiri::XML file.read
    file.close
    read_table('domains.xml', @dir, 'domains').each do |entry|
      parent_id = read_column('dom_parent', entry).to_i
      name = read_column('dom_name', entry)
      description = read_column('dom_desc', entry)
      parent = nil
      xml_file.xpath("//column[@name='dom_id']").each do |node|
        parent = node if node.children.first.to_s.to_i == parent_id
      end
      parent_name = parent.xpath("../column[@name='dom_name']").children.first.to_s if parent.present?
      parent_sql = Domain.find_by_name parent_name
      if parent_sql.present?
        parent_sql.children.create(name: name, description: description)
      else
        Domain.create!(name: name, description: description)
      end
    end
    puts 'all done.'
  end

  desc "Migrate the document type and the study levels form the old table document"
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

  def find(xml_file, equal_to, parent_id, parent_name, klass, find_for_sql='name')
    parent = nil
    xml_file.xpath("//column[@name='#{parent_id}']").each do |node|
      parent = node if node.children.first.to_s.to_i == equal_to
    end
    parent_name = parent.xpath("../column[@name='#{parent_name}']").children.first.to_s if parent.present?
    eval("#{klass}.find_by_#{find_for_sql}(#{parent_name})")
  end

  def read_table(file_name, path, table_name)
     file = File.open path+'/'+file_name
    xml = Nokogiri::XML file.read
    file.close
    xml.xpath("//table[@name='#{table_name}']")
  end

  def read_column(column_name, node, xpath_expression='')
    node.xpath("column[@name='#{column_name}']").children.first.to_s
  end

  def to_seed(values, klass='', field = 'name', more = "description: 'A compléter'")
    result = ''
     values.each do |value|
       result += "{#{field}: '#{value}', #{more}},\n"
     end
    result.chop.chop
  end

  def collect_data(value, output)
    output<<value unless output.include? value
    output
  end

  def load_xml(file_name)
    file = File.open "#{@dir}/#{file_name}"
    xml_user = Nokogiri::XML(file.read)
    file.close
    xml_user
  end
end