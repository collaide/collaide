u = User.create!(
    name: 'Texicitys',
    email: 'texicitys@gmail.com',
    password: 'b3c3005c19f07cbc7096cb7bf8bb43cc',
    password_confirmation: 'b3c3005c19f07cbc7096cb7bf8bb43cc',
    old_password: 'b3c3005c19f07cbc7096cb7bf8bb43cc',
    points: 126,
    old_id: 1
)
u.created_at = DateTime.parse('2011-05-16 16:29:34')
u.last_sign_in_at = DateTime.parse('2014-05-08 11:12:22')
u.save
u = User.create!(
    name: 'facenord',
    email: 'facenord.sud@gmail.com',
    password: '6a819ea5806e1dfe841744583e8b3146',
    password_confirmation: '6a819ea5806e1dfe841744583e8b3146',
    old_password: '6a819ea5806e1dfe841744583e8b3146',
    points: 15,
    old_id: 260
)
u.created_at = DateTime.parse('2012-10-02 20:10:45')
u.last_sign_in_at = DateTime.parse('2014-04-17 11:07:53')
u.save
result = OldCollaide.instance.client.query('SELECT * FROM membres')
result.each do |r|
  if r['mem_pseudo'] == 'facenord' or r['mem_pseudo'] == 'Texicitys'
    next
  end
  u = User.new(
      name: r['mem_pseudo'],
      email: r['mem_mail'],
      password: r['mem_pass'],
      password_confirmation: r['mem_pass'],
      created_at: DateTime.parse(r['mem_date'].to_s),
      points: r['mem_points'],
      old_password: r['mem_pass'],
      old_user: true,
      old_id: r['mem_ID']
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