class AddIndexToPicturesOnYearAndMonth < ActiveRecord::Migration[7.2]
  def change
    add_index :pictures, [:year, :month]
  end
end
