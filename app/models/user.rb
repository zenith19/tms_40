class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TYPES = {
    trainee: "0",
    supervisor: "1"
  }
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  
  has_many :activities
  has_many :users_courses
  has_many :courses, through: :users_courses
  has_many :users_subjects
  has_many :courses_subjects, through: :users_subjects
  has_many :subjects, through: :courses_subjects
  has_many :tasks, through: :users_tasks
  
  scope :supervisors, -> { where(supervisor: true) }
  scope :trainees, -> { where(supervisor: false) }

  def full_name
    [first_name, last_name].join(" ")
  end
end