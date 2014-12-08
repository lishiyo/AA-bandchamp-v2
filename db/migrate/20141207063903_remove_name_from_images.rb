class RemoveNameFromImages < ActiveRecord::Migration
  def change
		remove_column :images, :name
		add_column :images, :attachment, :string
  end
end
