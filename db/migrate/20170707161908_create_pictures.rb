class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :user
      t.string :image_title
      t.string :caption
      t.string :description
      t.string :month
      t.integer :year
      t.string :image

      t.timestamps
    end
  end
end
