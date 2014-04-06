class OldCollaide
  include Singleton

  attr_reader :client

  def initialize
    @client = Mysql2::Client.new(host: 'localhost', user: 'root', password: 'root', socket: '/Applications/MAMP/tmp/mysql/mysql.sock', database: 'collaidebase')
  end

  def self.folder_path
    '/Users/leo/Downloads/collaide'
  end

  def self.open_file(old_name, file)
    begin
      File.rename(folder_path+'/documents/'+old_name, folder_path+'/documents/'+file)
    rescue Exception
      puts 'already renamed: '+old_name
    end
    File.open(folder_path+'/documents/'+file)
  end
end