# -*- encoding : utf-8 -*-

class UserUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  storage :file


  def default_url
      ActionController::Base.helpers.asset_path('users/no-avatar.png')
  end

   # Override the directory where uploaded files will be stored.
   # This is a sensible default for uploaders that are meant to be mounted:
   def store_dir
     "#{Rails.root.join('public')}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   end

   version :large do
    process :resize_to_fill => [200, 200]
  end

  version :mini do
    process resize_to_fill: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png JPG JPEG)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
