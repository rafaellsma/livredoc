class ConversionService
  OUTPUT_PATH = "#{Rails.root}/public/files"

  def self.to_pdf(file_path, store_dir = OUTPUT_PATH)
    Docsplit.extract_pdf(file_path,
      output: store_dir)
  end
end
