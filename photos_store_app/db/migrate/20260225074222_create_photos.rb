class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :image_url
      t.string :external_id

      t.timestamps
    end
  end
end
