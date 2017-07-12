class RenameUserToPhotographerInPicture < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :user, :photographer
  end
end
