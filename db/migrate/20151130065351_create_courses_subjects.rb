class CreateCoursesSubjects < ActiveRecord::Migration
  def change
    create_table :courses_subjects do |t|
      t.references :course, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :status, limit: 1, default: 0

      t.timestamps null: false
    end
  end
end
