class AddFieldsToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :artist, :string
    add_column :songs, :title, :string
    add_column :songs, :explicit,:boolean
    add_column :songs, :popularity, :integer
    add_column :songs, :image_uri, :string
  end
end
