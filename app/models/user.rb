class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_paranoid
  TYPES = {
    trainee: "0",
    supervisor: "1"
  }
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

  scope :supervisors, -> {where supervisor: true}
  scope :trainees, -> {where supervisor: false}
  scope :free,  -> {
    joins(:courses).where.not courses: {status: Course::STATUS[:finished]} 
  }  
  scope :assignable_trainees, ->(course) {
    excluded_trainees_ids = free.trainees.ids - course.users.trainees.ids
    where.not(id: excluded_trainees_ids).trainees
  }

  def full_name
    [first_name, last_name].join " "
  end
end