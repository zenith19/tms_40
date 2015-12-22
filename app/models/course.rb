class Course < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  enum status: [:created, :started, :finished]
  attr_accessor :update_status, :assigned_users, :removed_users

  has_many :users_courses, dependent: :destroy
  has_many :courses_subjects, dependent: :destroy
  has_many :users, through: :users_courses
  has_many :subjects, through: :courses_subjects
  has_many :users_subjects, through: :courses_subjects
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_date

  after_initialize :default_values
  scope :near_deadline, ->{where "end_date < ?", 5.days.since}

  User.roles.each_key do |key|
    define_method "#{key}s" do
      users.send key
    end
  end

  def progress
    return 0 if users_subjects.size.zero?
    users_subjects.finished.size * 100 / users_subjects.size
  end

  def load_activities user = nil
    if user
      PublicActivity::Activity.order("created_at desc").
        where owner_id: user.id, trackable_id: id
    else
      PublicActivity::Activity.order("created_at desc").
        where trackable_type: "Course", trackable_id: id
    end    
  end

  def update_status!
    if created?
      started!
    elsif started?
      finished!
    end
    save!
  end

  def valid_for_status_update? has_status
    (started? && !has_status) || finished?
  end

  def start_must_be_before_end_date
    unless (start_date == nil || end_date == nil)
      errors.add(:start_date, "must be before end date") unless 
      self.start_date < self.end_date
    end
  end

  def default_values
    self.assigned_users ||= []
    self.removed_users ||= []
  end
end
