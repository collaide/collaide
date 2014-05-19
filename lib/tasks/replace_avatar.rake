namespace :avatar do
  desc 'change the avatar url'
  task change: :environment do
    User.all.each do |user|
      old_image = user.avatar.to_s.split('/').last
      next if old_image == 'no-avatar.png'
      user.avatar = File.open File.join(Rails.root, 'public', 'uploads', old_image)
      user.save!
      puts user.avatar.to_s
    end
  end
end