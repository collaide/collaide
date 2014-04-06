result = OldCollaide.instance.client.query('SELECT * FROM tab_works')
result.each do |r|
  begin
    Document::Type.find_by name: r['work_type']
  rescue Exception
    Document::Type.create(name: r['work_type'], description: '')
  end
end