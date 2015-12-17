class AddDeletedAtToUsersSubjects < ActiveRecord::Migration
  def change
    add_column :users_subjects, :deleted_at, :datetime
    add_index :users_subjects, :deleted_at
  end
end
