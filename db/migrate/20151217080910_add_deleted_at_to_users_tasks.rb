class AddDeletedAtToUsersTasks < ActiveRecord::Migration
  def change
    add_column :users_tasks, :deleted_at, :datetime
    add_index :users_tasks, :deleted_at
  end
end
