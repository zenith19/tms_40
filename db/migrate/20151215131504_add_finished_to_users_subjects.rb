class AddFinishedToUsersSubjects < ActiveRecord::Migration
  def change
    add_column :users_subjects, :finished, :boolean, default: false
  end
end
