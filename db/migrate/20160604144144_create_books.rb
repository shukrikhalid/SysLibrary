class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.string :book_isbn
    	t.string :book_title
    	t.string :book_author
    	t.string :book_status
    	t.integer :book_edition
    	t.string :book_image
      t.timestamps null: false
    end
  end
end
