class Course < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :users_courses
  has_many :subjects, through: :courses_subjects
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_date

  private
  def start_must_be_before_end_date
    errors.add(:start_date, "must be before end date") unless
    start_date < end_date
  end
end