class CreateCoursesSubjectsTasks < ActiveRecord::Migration
  def change
    create_table :courses_subjects_tasks do |t|
      t.references :courses_subject, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
