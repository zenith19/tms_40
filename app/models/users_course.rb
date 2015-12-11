class UsersCourse < ActiveRecord::Base

  ASSIGN_TYPE = {
    supervisor: "supervisor",
    trainee: "trainee"
  }

  belongs_to :user
  belongs_to :course

  scope :supervisors, ->{ where supervisor: true }
  scope :trainees, ->{ where supervisor: false }
end