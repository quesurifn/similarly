class AddDuration < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :duration_ms, :integer
  end
end
