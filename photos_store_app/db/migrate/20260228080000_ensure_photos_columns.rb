class EnsurePhotosColumns < ActiveRecord::Migration[8.1]
  def change
    return unless table_exists?(:photos)

    if column_exists?(:photos, :title) && !column_exists?(:photos, :name)
      rename_column :photos, :title, :name
    end

    add_column :photos, :name, :string unless column_exists?(:photos, :name)
    add_column :photos, :price, :decimal unless column_exists?(:photos, :price)
    add_column :photos, :image_url, :string unless column_exists?(:photos, :image_url)
    add_column :photos, :external_id, :string unless column_exists?(:photos, :external_id)
  end
end
