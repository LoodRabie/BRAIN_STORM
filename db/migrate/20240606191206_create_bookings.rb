class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :brain, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :length_of_time
      t.date :start_date
      t.string :status

      t.timestamps
    end
  end
end
