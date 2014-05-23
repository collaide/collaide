class ManageLog
  def every_days
    return unless Rails.env = 'production'
    date = DateTime.now
    file_month = File.join(Rails.root, 'log', date.strftime('%Y-%m'))
    Dir.mkdir(file_month, 0666) unless File.exist?(file_month)
    log_file = File.join(Rails.root, 'log', "#{Rails.env}.log")
    FileUtils.cp "#{log_file}", "#{file_month}/#{date.strftime('%Y-%m-%d')}.log"
  end
end