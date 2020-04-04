class RenameField2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :songs, :preview_uri, :preview_url
  end
end
