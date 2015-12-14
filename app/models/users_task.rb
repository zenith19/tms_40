class UsersTask < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  belongs_to :user
  belongs_to :task

  class << self
    def find_task_id user_id, task_id
      UsersTask.find_by "user_id = ? and task_id = ?", user_id, task_id
    end
  end
end
