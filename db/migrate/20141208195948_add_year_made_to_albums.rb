class AddYearMadeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :year_made, :date
    remove_column :users, :avatar
    remove_column :bands, :avatars
    remove_column :albums, :avatar
  end
end
