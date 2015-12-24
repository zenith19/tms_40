class UsersCourse < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  after_create :appened_assigned_users
  after_destroy :appened_removed_users

  belongs_to :user
  belongs_to :course

  def appened_assigned_users
    course.assigned_users << user
  end

  def appened_removed_users
    course.removed_users << user
  end
end
