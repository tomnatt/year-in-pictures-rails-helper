class ConvertMonthToInteger < ActiveRecord::Migration[5.1]
  def up
    remove_column :pictures, :month
    add_column :pictures, :month, :integer
  end

  def down
    t.remove_column :pictures, :month
    t.add_column :pictures, :month, :string
  end
end
