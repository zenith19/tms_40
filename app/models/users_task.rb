class UsersTask < ActiveRecord::Base
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid
  belongs_to :user
  belongs_to :task
end
