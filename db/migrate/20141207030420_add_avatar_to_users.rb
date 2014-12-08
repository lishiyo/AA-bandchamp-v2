class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
		add_column :bands, :avatars, :string
		add_column :albums, :avatar, :string
		
		add_index :albums, :band_id
		add_index :bands, :name
  end
end
