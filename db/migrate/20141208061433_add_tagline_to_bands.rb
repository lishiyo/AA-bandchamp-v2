class AddTaglineToBands < ActiveRecord::Migration
  def change
    add_column :bands, :tagline, :string
  end
end
