class ChangeDescriptionDatatype < ActiveRecord::Migration[5.1]
  def up
    change_table :pictures do |t|
      t.change :description, :text
    end
  end

  def down
    change_table :pictures do |t|
      t.change :description, :string
    end
  end
end
