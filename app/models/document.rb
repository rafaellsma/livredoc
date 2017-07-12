class Document < ApplicationRecord
  mount_uploader :file, DocumentUploader

  process_in_background :file


  validates :file, presence: true

  def pdf_path
   "#{Rails.root}/public/files/" + pdf
  end
end
