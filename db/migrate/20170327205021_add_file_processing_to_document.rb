class AddFileProcessingToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :file_processing, :boolean, null: false, default: false
  end
end
