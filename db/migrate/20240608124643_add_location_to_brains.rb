class AddLocationToBrains < ActiveRecord::Migration[7.1]
  def change
    add_column :brains, :location, :string
  end
end
