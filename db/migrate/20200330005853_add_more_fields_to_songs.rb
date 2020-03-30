class AddMoreFieldsToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :preview_link, :string
    add_column :songs, :uri, :string
  end
end
