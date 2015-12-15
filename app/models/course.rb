class Course < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  tracked recipient: ->(controller, model) {model && model}

  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }
  attr_accessor :update_status, :assigned_users, :removed_users

  has_many :users_courses, dependent: :destroy
  has_many :courses_subjects, dependent: :destroy
  has_many :users, through: :users_courses
  has_many :subjects, through: :courses_subjects
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_date

  after_initialize :default_values
  scope :near_deadline, ->{where "end_date < ?", 5.days.since}

  def trainees
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", false, id)
  end

  def supervisors
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", true, id)
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

  def start_must_be_before_end_date
    errors.add(:start_date, "must be before end date") unless
    self.start_date < self.end_date
  end

  def default_values
    self.assigned_users ||= []
    self.removed_users ||= []
  end
end
