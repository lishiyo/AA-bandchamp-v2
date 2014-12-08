class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
			t.integer :band_id, null: false
      t.boolean :studio
			t.boolean :live

      t.timestamps
    end
		
		
  end
end
