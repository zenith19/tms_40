class UsersSubject < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:created, :started, :finished]
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}

  belongs_to :user
  belongs_to :courses_subject
  belongs_to :subject

  class << self
    def find_by_user user_id
      UsersSubject.find_by user_id: user_id, finished: true
    end
  end
end
