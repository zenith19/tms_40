class CreateUsersSubjects < ActiveRecord::Migration
  def change
    create_table :users_subjects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :courses_subject, index: true, foreign_key: true
      t.integer :status, limit: 1, default: 0

      t.timestamps null: false
    end
  end
end
