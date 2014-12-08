class CreateBandMembers < ActiveRecord::Migration
  def change
    create_table :band_members do |t|
			t.integer :band_id
      t.string :name, null: false
      t.date :birth_date
      t.string :gender
      t.text :description
			t.boolean :solo

      t.timestamps
    end
		
		add_index :band_members, :band_id
		add_index :band_members, [:band_id, :name], unique: true
  end
end
