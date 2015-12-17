class CoursesSubjectsTask < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  tracked recipient: ->(controller, model) {model && model}
  belongs_to :courses_subject
  belongs_to :task
end
