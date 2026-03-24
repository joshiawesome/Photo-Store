class CreateVariantAttributes < ActiveRecord::Migration[8.1]
  def change
    create_table :variant_attributes do |t|
      t.string :variant_id, null: false
      t.foreign_key :variants, column: :variant_id

      t.text :description
      t.string :color_name
      t.string :color_swatch
      t.string :size_name

      t.timestamps
    end
  end
end
