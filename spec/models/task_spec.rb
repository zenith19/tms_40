require "rails_helper"

describe Task do

  it "has a valid factory" do
    expect(FactoryGirl.create :task).to be_valid
  end

  it {expect validate_presence_of :name}
  it {expect validate_presence_of :subject_id}

  it {expect have_many :courses_subjects_tasks}
  it {expect have_many :users_tasks}
  it {should belong_to :subject}
end
