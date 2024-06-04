class CreateBrains < ActiveRecord::Migration[7.1]
  def change
    create_table :brains do |t|
      t.string :name
      t.text :characteristics
      t.text :description
      t.text :specialities
      t.references :user, null: false, foreign_key: true
      t.boolean :available

      t.timestamps
    end
  end
end
