result = OldCollaide.instance.client.query('SELECT * FROM tab_works')
result.each do |r|
  begin
    doc = Document::Type.find_by name: r['work_type']
    #puts "doc_type '#{doc.name}' exist"
  rescue Exception
    doc = Document::Type.create!(name: r['work_type'], description: 'A compléter') if r['work_type'].present?
    #puts "doc_type: '#{doc.name}' created" if doc.present?
  end
end
#Document::Type.create!(name: 'Guide méthodologique', description: 'a compléter')