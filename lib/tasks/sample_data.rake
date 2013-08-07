namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    #make_guest_books
    #make_study_levels
    #make_document_types
    #make_domains
    #make_files
  end
end

def make_users
  99.times do |n|
    name  = Faker::Name.name
    email = "exemple-#{n+1}@collaide.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

  def make_guest_books
     3322.times do |n|
       name = Faker::Name.name
       comment = Faker::Lorem.sentence 12
       GuestBook.create!(
           name: name,
           comment: comment
       )
     end
  end

  def make_study_levels
      120.times do |n|
        name = Faker::Lorem.characters 12
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
            a.name = Faker::Lorem.characters 12
            a.description = Faker::Lorem.sentences 1
            a.save
          end
        end
  end

  def make_document_types
    120.times do |n|
      name = Faker::Lorem.characters 12
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
          a.name = Faker::Lorem.characters 12
          a.description = Faker::Lorem.sentences 1
          a.save
        end
      end
  end

  def make_domains
    120.times do |n|
      name = Faker::Lorem.characters 12
      description = Faker::Lorem.sentences 1
      Domain.create!(
          name: name,
          description: description
      )
    end
      all = Domain.all
      all.each do |a|
        I18n.available_locales.each do |l|
          I18n.locale = l
          a.name = Faker::Lorem.characters 12
          a.description = Faker::Lorem.sentences 1
          a.save
        end
      end
  end

def make_files
  3000.times do |n|
    file_name = Faker::Lorem.characters 12
    file_size = Random.new.rand(100..100000)
    CFile::CFile.create!(
        file: {
            file_name: file_name,
            file_content_type: "image/jpeg",
            file_size: file_size
        },
        rights: %w[read]
    )
  end
end

  def make_documents

  end