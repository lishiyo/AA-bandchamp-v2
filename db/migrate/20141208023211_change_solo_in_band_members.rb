class ChangeSoloInBandMembers < ActiveRecord::Migration
  def change
		change_column :band_members, :solo, :boolean, default: false
  end
end
