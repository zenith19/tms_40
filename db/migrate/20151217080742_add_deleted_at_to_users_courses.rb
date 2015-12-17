class AddDeletedAtToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :deleted_at, :datetime
    add_index :users_courses, :deleted_at
  end
end
