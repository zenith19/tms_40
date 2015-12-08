class CreateUsersSubjects < ActiveRecord::Migration
  def change
    create_table :users_subjects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :courses_subject, index: true, foreign_key: true
      t.boolean :finished, default: false

      t.timestamps null: false
    end
  end
end
