class AddTrackTypeToAlbums < ActiveRecord::Migration
  def change
		remove_column :albums, :live
		remove_column :albums, :studio
		
    add_column :albums, :album_type, :string
  end
end
