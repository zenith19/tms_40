class UsersSubject < ActiveRecord::Base
  acts_as_paranoid
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}

  belongs_to :user
  belongs_to :courses_subject
  belongs_to :subject
  scope :finished, ->{where status: STATUS[:finished]}

  class << self
    def find_by_user user_id
      UsersSubject.find_by user_id: user_id, finished: true
    end
  end

  def new?
    status == STATUS[:new]
  end

  def started?
    status == STATUS[:started]
  end

  def finished?
    status == STATUS[:finished]
  end
end
