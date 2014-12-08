class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :user_id
      t.references :notable, polymorphic: true
      t.timestamps

      t.timestamps
    end

    add_index :notes, [:notable_id, :notable_type]
    add_index :notes, :user_id
  end
end
