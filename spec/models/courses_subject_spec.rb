require "rails_helper"

describe CoursesSubject do
  it {should belong_to :course}
  it {should belong_to :subject}
  it {should have_many :users_subjects}
  it {should have_many :users}
  it {should have_many :courses_subjects_tasks}
  it {should have_many :tasks}
end
