class CreateImages < ActiveRecord::Migration[8.1]
  def change
    create_table :images, id: false do |t|
      t.string :id, primary_key: true

      t.string :url
      t.string :transformed_url

      t.integer :width
      t.integer :height

      # polymorphic association
      # images can belong to any/have relation to any model
      t.string :imageable_type
      t.string :imageable_id

      t.timestamps
    end

    # speeds up queries by imageable_type and imageable_id
    # acts like a lookup table for images instead of scanning all images
    add_index :images, [:imageable_type, :imageable_id]
  end
end
