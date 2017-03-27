class AddPdfToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :pdf, :string
  end
end
