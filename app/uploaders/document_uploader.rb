class DocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::UNOConv
  include ::CarrierWave::Backgrounder::Delay

  version :pdf do
    process uno_convert: 'pdf'

    def full_filename(for_file)
      super(for_file).chomp(File.extname(super(for_file))) + '.pdf'
    end
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(ppt pptx pdf)
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest model.send(mounted_as).read.to_s
  end

  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end
end
