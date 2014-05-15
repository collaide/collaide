result = OldCollaide.instance.client.query('SELECT * FROM tab_works')
result.each do |r|
  next if r['work_domain'].to_i == 0
  pages = r['work_pages'].to_i
  pages = 1 if pages == 0
  level = nil
  type = nil
  user = nil
  domains = []
  case r['work_degre']
    when 'primaire'
      level = :primary
    when 'secondaire'
      level = :secondary
    when 'supérieur'
      level = :college
    when 'universitaire'
      level= :university
    else level = :university
  end
  old_user = OldCollaide.instance.client.query("SELECT * FROM membres WHERE mem_ID=#{r['work_autor']}").first
  begin
    user = User.find_by name: old_user['mem_pseudo']
  rescue Exception
    user = User.find 1
  end
  old_domain = OldCollaide.instance.client.query("SELECT * FROM domains WHERE dom_id=#{r['work_domain']}").first
  begin
    domains << Domain.find_by(name: old_domain['dom_name'])
  rescue Exception
    domains << Domain.find(1)
  end
  type = Document::Type.find_by name: r['work_type'].gsub(/\\/, '')
  #type.nil? ? puts("type nil for #{r['work_name']}") : puts("type: #{type.name}")
  begin
  doc = Document::Document.create!(
      old_id: r['work_id'].to_i,
      title: r['work_name'],
      description: r['work_desc'],
      author: r['work_autors'],
      number_of_pages: pages,
      created_at: r['work_date'],
      hits: r['work_hits'],
      realized_at: Date.new(r['work_dateR']),
      asset: OldCollaide.instance.open_file(r['doc_name_serv'], r['doc_name']),
      status: :accepted,
      language: :french,
      user: user,
      study_level: level,
      document_type: type,
      domains: domains
  )
  rescue Exception => e
    puts "'#{r['work_name']}' not created: #{e}"
    end
  #doc.rate(r['work_stars'], User.find(1))
  #doc.save
  #puts 'doc created'
end