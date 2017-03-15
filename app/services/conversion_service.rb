class ConversionService
  OUTPUT_PATH = "#{Rails.root}/public/files"

  def self.to_pdf(file_path)
    Docsplit.extract_pdf(file_path,
      output: OUTPUT_PATH)
  end
end
