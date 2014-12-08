class CreateGenreTaggings < ActiveRecord::Migration
  def change
    create_table :genre_taggings do |t|
			t.integer :album_id, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end
		
		add_index :genre_taggings, :album_id
		add_index :genre_taggings, :genre_id
		add_index :genre_taggings, [:album_id, :genre_id], unique: true
  end
end
