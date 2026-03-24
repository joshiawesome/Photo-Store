class CreateVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :variants, id: false do |t|
      t.string :id, primary_key: true
      
      t.string :product_id
      t.foreign_key :products, column: :product_id

      t.string :name
      t.string :sku

      t.decimal :price_value
      t.string :price_currency
      t.decimal :compare_at_price_value
      t.string :compare_at_price_currency

      t.string :stock_type

      t.decimal :weight_value
      t.string :weight_unit

      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.string :dimension_unit

      t.timestamps
    end
  end
end
