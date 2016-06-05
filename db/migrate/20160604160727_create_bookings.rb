class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
    	t.date :booking_date_start
    	t.date :booking_date_end
    	t.date :booking_date_return
    	t.string :status
    	t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
