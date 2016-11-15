# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.id}/"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, :if => :pdf? do
    process :resize_to_fit => [360, 360]
    process :convert => :jpg
    process :set_content_type
  end

  version :normal, :if => :video? do
    process thumbnail: [{format: 'png', quality: 10, size: 360, strip: true, logger: Rails.logger}]
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  def set_content_type(*args)
    self.file.instance_variable_set(:@content_type, "image/jpeg")
  end

  protected
  def pdf?(new_file)
    new_file.content_type.include? 'pdf'
  end

  def video?(new_file)
    new_file.content_type.include? 'video'
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png mp4 m4v webm ogg pdf)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
