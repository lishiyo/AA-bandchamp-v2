class RemoveAvatarsFromBands < ActiveRecord::Migration
  def change
		remove_column :bands, :avatars
		
		add_column :bands, :avatars, :json
  end
end
