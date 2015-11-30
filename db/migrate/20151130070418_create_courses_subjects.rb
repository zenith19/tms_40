class CreateCoursesSubjects < ActiveRecord::Migration
  def change
    create_table :courses_subjects do |t|
      t.references :course, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.date :deadline

      t.timestamps null: false
    end
  end
end
