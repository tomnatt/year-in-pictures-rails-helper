class RemovePhotographerFromPicture < ActiveRecord::Migration[5.1]
  def change
    remove_column :pictures, :photographer, :string
  end
end
