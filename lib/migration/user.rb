result = OldCollaide.instance.client.query('SELECT * FROM membres')
result.each do |r|
  u = User.new(
      name: r['mem_pseudo'],
      email: r['mem_mail'],
      password: r['mem_pass'],
      password_confirmation: r['mem_pass'],
      created_at: DateTime.parse(r['mem_date'].to_s),
      points: r['mem_points'],
      old_password: r['mem_pass'],
      old_user: true
  )
  begin
    u.last_sign_in_at = DateTime.parse(r['mem_date_last'].to_s)
  rescue Exception
    #puts 'never connected'
  end
  u.avatar = File.open("#{OldCollaide.instance.folder_path}/users/#{r['mem_avatar']}") unless r['mem_avatar'].blank?
  u.save!
  #puts "user #{u.name} created"
end