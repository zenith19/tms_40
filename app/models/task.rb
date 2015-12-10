class Task < ActiveRecord::Base
  has_many :users_tasks
  has_many :users, through: :users_tasks
end
