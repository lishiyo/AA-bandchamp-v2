class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
			t.integer :album_id, null: false
      t.time :length
      t.string :track_type
      t.text :lyrics

      t.timestamps
    end
		
		add_index :tracks, :album_id
  end
end
