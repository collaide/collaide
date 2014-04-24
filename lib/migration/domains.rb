result = OldCollaide.instance.client.query('SELECT * FROM domains')
result.each do |r|
  parent = nil
  begin
    old_parent = client.query("SELECT * FROM domains WHERE dom_id=#{r['dom_parent']}").first
    parent = Domain.find_by name: old_parent['dom_name']
  rescue
    puts 'parent nil'
  ensure
    d = Domain.create(name: r['dom_name'], description: '', parent: parent)
    puts "#{d.name} created."
  end
end