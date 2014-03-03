namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    #add_avatar_to_user
    make_guest_books
    #make_study_levels
    make_document_types
    make_domains
    #make_files
    #make_documents
  end

  desc "Drop database, create a new one, migrate and seed"
  task recreate: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
end

def make_users
  500.times do |n|
    name  = Faker::Internet.user_name
    email = Faker::Internet.email
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
    )
  end
end

def add_avatar_to_user
  User.all.each { |user| user.avatar = File.open(Dir.glob(File.join('C:\Users\Yves\Pictures', '*', '*.jpg')).sample); user.save! }
end

  def make_guest_books
    puts 'starting guest book'
     3322.times do |n|
       name = Faker::Internet.user_name
       if name.size <=3
         name = 'Sam Bass'
       end
       comment = Faker::Lorem.sentence 12
       GuestBook.create!(
           name: name,
           comment: comment
       )
     end
    puts 'ending guest book'
  end

  def make_study_levels
    puts 'starting study level'
    120.times do |n|
        name = Faker::Lorem.characters Random.new.rand(5..30)
        description = Faker::Lorem.sentences 1
         Document::StudyLevel.create!(
             name: name,
             description: description
         )
      end

      all = Document::StudyLevel.all
        all.each do |a|
          I18n.available_locales.each do |l|
            I18n.locale = l
            a.name = Faker::Lorem.characters Random.new.rand(5..30)
            a.description = Faker::Lorem.sentences 1
            a.save
          end
        end
      puts 'ending guest book'
  end

  def make_document_types
    puts 'starting document types'
    120.times do |n|
      name = Faker::Lorem.characters Random.new.rand(5..30)
      description = Faker::Lorem.sentences 1
      Document::Type.create!(
          name: name,
          description: description
      )
    end
      all = Document::Type.all
      all.each do |a|
        I18n.available_locales.each do |l|
          I18n.locale = l
          a.name = Faker::Lorem.characters Random.new.rand(5..30)
          a.description = Faker::Lorem.sentences 1
          a.save
        end
      end
    puts 'ending document types'
  end

  def make_domains
    puts 'starting domains'
    I18n.locale = :fr
    120.times do |n|
      name = Faker::Lorem.characters Random.new.rand(5..30)
      description = Faker::Lorem.sentences 1
      Domain.create!(
          name: name,
          description: description
      )
    end
    I18n.locale = :en
    all = Domain.all
    all.each do |a|
       a.name = Faker::Lorem.characters Random.new.rand(5..30)
      a.description = Faker::Lorem.sentences 1
      a.save
    end
    puts 'ending domains'
  end

def make_files
  puts 'files'
  30.times do |n|
    file = File.open(Dir.glob(File.join('D:\Education\Unifr\Algorithmes', '*', '*.pdf')).sample)
    CFile::CFile.create!(
        file: file ,
        rights: %w[read write]
    )
    puts "file # #{n} created"
  end
  puts 'ending files'
end

  def make_documents
    puts 'starting document'
    all_study = Document::StudyLevel.all
    all_types = Document::Type.all
    all_user = User.all
    all_files = CFile::CFile.all
    all_domains = Domain.all
    r = Random.new
     50.times do |n|
       title = Faker::Lorem.words Random.new.rand(3..10)
       description = Faker::Lorem.sentences Random.new.rand(4..10)
       author = Faker::Name.name
       number_of_pages = Random.new.rand(1..100)
       realized_at = r.rand(0..50).years.ago
       language = I18n.translate("translation.#{I18n.available_locales.sample.to_s}")
       study_level = all_study.sample
       document_type = all_types.sample
       user = all_user.sample
       files = all_files[(r.rand(0..all_files.size)-1)..(r.rand(0..all_files.size)-1)-((r.rand(0..all_files.size)-1)/2)]
       domains = all_domains[(r.rand(0..all_domains.size)-1)..(r.rand(0..all_domains.size)-1)]

       doc = Document::Document.new
       doc.title = title
       doc.description = description
       doc.author = author
       doc.number_of_pages = number_of_pages
       doc.realized_at = realized_at
       doc.language = language
       doc.study_level = study_level
       doc.document_type = document_type
       doc.domains = domains
       doc.user = user
       doc.files = files
       doc.save
       puts " document ##{n} created"
     end
    puts 'ending document...'
  end