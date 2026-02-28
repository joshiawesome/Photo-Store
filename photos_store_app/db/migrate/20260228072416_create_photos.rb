class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :external_id
      t.string :image_url
      t.decimal :price

      t.timestamps
    end
  end
end
