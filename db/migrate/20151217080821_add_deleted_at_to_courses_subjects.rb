class AddDeletedAtToCoursesSubjects < ActiveRecord::Migration
  def change
    add_column :courses_subjects, :deleted_at, :datetime
    add_index :courses_subjects, :deleted_at
  end
end
