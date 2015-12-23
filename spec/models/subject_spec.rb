require "rails_helper"

describe Subject do

  it "has a valid factory" do
    expect(FactoryGirl.create :subject).to be_valid
  end

  it {expect validate_presence_of :name}
  it {expect validate_presence_of :description}

  it {expect have_many :users}
  it {expect have_many :tasks}
  it {expect have_many :courses_subjects}

  it{ expect accept_nested_attributes_for :tasks }
end
