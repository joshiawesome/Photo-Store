class CreateAdditionalInformations < ActiveRecord::Migration[8.1]
  def change
   create_table :additional_informations do |t|
    t.string :product_id
    t.foreign_key :products, column: :product_id

    t.string :info_type
    t.string :title
    t.text :body_html

    t.timestamps
    end
  end
end
