class AddImageToEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :entries, :image, :string
  end
end
