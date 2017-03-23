class DocumentUploader < CarrierWave::Uploader::Base
  after :store, :convert_to_pdf

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(ppt pptx)
  end

  def convert_to_pdf(file)
    ConversionService.to_pdf(model.file.path)
    model.pdf = model.file.md5 + '.pdf'
    model.save
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest model.send(mounted_as).read.to_s
  end

  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end

end
