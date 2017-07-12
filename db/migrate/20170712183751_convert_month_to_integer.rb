class ConvertMonthToInteger < ActiveRecord::Migration[5.1]
  def up
    change_table :pictures do |t|
      t.change :month, :integer
    end
  end

  def down
    change_table :pictures do |t|
      t.change :month, :string
    end
  end
end
