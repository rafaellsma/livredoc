class RemovePdfFromDocument < ActiveRecord::Migration[5.0]
  def change
    remove_column :documents, :pdf, :string
  end
end
