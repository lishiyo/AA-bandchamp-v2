class AddSubmitterIdToBands < ActiveRecord::Migration
  def change
    add_column :bands, :submitter_id, :integer

    add_index :bands, :submitter_id
  end
end
