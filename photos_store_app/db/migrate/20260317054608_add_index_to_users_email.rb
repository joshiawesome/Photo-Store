class AddIndexToUsersEmail < ActiveRecord::Migration[8.1]
  def change
    # ensures email is unique
    add_index :users, :email, unique: true
  end
end
