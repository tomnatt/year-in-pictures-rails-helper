class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :fullname, unique: true
  end
end
