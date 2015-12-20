class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_paranoid

  enum role: [:trainee, :supervisor]
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :activities, dependent: :destroy
  has_many :users_courses, dependent: :destroy
  has_many :courses, through: :users_courses
  has_many :users_subjects, dependent: :destroy
  has_many :courses_subjects, through: :users_subjects
  has_many :subjects, through: :courses_subjects
  has_many :users_tasks, dependent: :destroy
  has_many :tasks, through: :users_tasks

  scope :free,  -> {
    joins(:courses).where.not courses: {status: Course.statuses[:finished]}
  }
  scope :assignable_trainees, ->(course) {
    excluded_ids = free.ids - course.users.ids
    where.not(id: excluded_ids).trainees
  }

  def full_name
    [first_name, last_name].join " "
  end
end
