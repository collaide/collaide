result = OldCollaide.instance.client.query('SELECT * FROM tab_works')
result.each do |r|
  next if r['work_domain'].to_i == 0
  pages = r['work_pages'].to_i
  pages = 1 if pages == 0
  doc = Document::Document.new(
      title: r['work_name'],
      description: r['work_desc'],
      author: r['work_autors'],
      number_of_pages: pages,
      created_at: r['work_date'],
      hits: r['work_hits'],
      realized_at: Date.new(r['work_dateR']),
      asset: OldCollaide.instance.open_file(r['doc_name_serv'], r['doc_name']),
      status: :accepted,
      language: :french
  )
  case r['work_degre']
    when 'primaire'
      doc.study_level = :primary
    when 'secondaire'
      doc.study_level = :secondary
    when 'supérieur'
      doc.study_level = :college
    when 'universitaire'
      doc.study_level= :university
    else doc.study_level = :university
  end
  old_user = OldCollaide.instance.client.query("SELECT * FROM membres WHERE mem_ID=#{r['work_autor']}").first
  begin
    doc.user = User.find_by name: old_user['mem_pseudo']
  rescue Exception
    doc.user = User.find 1
  end
  old_domain = OldCollaide.instance.client.query("SELECT * FROM domains WHERE dom_id=#{r['work_domain']}").first
  begin
    doc.domains << Domain.find_by(name: old_domain['dom_name'])
  rescue Exception
    doc.domains << Domain.find(1)
  end
  type = Document::Type.find_by name: r['work_type'].gsub(/\\/, '')
  #puts "type: #{r['work_type'].gsub(/\\/, '')}"
  doc.document_type = type
  begin
    doc.save!
  rescue Exception => e
    puts "'#{doc.title}' not created: #{e}"
  end
  #doc.rate(r['work_stars'], User.find(1))
  #doc.save
  #puts 'doc created'
end