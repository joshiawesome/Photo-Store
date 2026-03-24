class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products, id: false do |t|
      t.string :id , primary_key: true
      t.string :name
      t.string :slug
      t.text :description
      t.string :state
      t.string :access

      t.timestamps
    end
  end
end
