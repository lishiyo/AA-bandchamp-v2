class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
			t.string :name
			t.references :attachable, polymorphic: true
      t.timestamps
    end
  end
end
