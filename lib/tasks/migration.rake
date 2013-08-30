namespace :migration do
  desc "Migrate the documents from the old version"
  task documents: :environment do
    require 'Nokogiri'
     file = File.open '/Users/leo/Downloads/tab_works.xml'
     xml = Nokogiri::XML file.read
     file.close
     xml.xpath("//table[@name='tab_works']").each do |entry|
       entry.xpath("//column").each do |column|
         column_name = column.attributes.first[1].value
         puts "salut #{column_name}"
       end
     end
  end
end