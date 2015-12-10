class Course < ActiveRecord::Base

  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }
  def trainees
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", false, self.id)
  end
  
  def supervisors
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", true, self.id)
  end

  def new?
    self.status == STATUS[:new]
  end

  def started?
    self.status == STATUS[:started]
  end

  belongs_to :user
  has_many :users_courses
  has_many :users, through: :users_courses
  has_many :courses_subjects, dependent: :destroy
  has_many :subjects, through: :courses_subjects

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_date

  def start_must_be_before_end_date
    errors.add(:start_date, "must be before end date") unless
    self.start_date < self.end_date
  end
end
