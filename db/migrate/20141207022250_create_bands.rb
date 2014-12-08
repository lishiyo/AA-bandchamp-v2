class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
			t.string :name, null: false
			t.date :date_created

      t.timestamps
    end
		
		
  end
end
