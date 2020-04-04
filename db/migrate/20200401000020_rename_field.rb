class RenameField < ActiveRecord::Migration[6.0]
  def change
    rename_column :songs, :preview_link,:preview_uri
  end
end
