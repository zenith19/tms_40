class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TYPES = {
    trainee: '0',
    supervisor: '1'
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities
  has_many :users_course
  has_many :courses, through: :users_course
  has_many :users_subjects
  has_many :subjects, through: :users_subject
  has_many :tasks, through: :users_tasks

  scope :supervisors, -> { where(supervisor: true) }
  scope :trainees, -> { where(supervisor: false) }

  def full_name
    first_name+ " " + last_name
  end
end
