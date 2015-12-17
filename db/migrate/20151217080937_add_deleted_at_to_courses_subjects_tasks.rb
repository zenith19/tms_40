class AddDeletedAtToCoursesSubjectsTasks < ActiveRecord::Migration
  def change
    add_column :courses_subjects_tasks, :deleted_at, :datetime
    add_index :courses_subjects_tasks, :deleted_at
  end
end
