class CreateQueries < ActiveRecord::Migration[6.0]
  def change
    create_table :queries do |t|
      t.string :query
      t.timestamps

      t.index :query
    end
  end
end
