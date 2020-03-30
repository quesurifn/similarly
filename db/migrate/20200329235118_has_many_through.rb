class HasManyThrough < ActiveRecord::Migration[6.0]
  def change
    add_column :results, :query_id, :integer
    add_column :results, :song_id, :integer
  end
end
