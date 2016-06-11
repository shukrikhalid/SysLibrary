class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
    	t.float :fines_amount
    	t.string :fines_status
    	t.date :fines_date_pay
    	t.references :booking, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
