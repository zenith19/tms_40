class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :status, limit: 1

      t.timestamps null: false
    end
  end
end
