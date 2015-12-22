require "rails_helper"

describe Course do

  it "has a valid factory" do
    expect(FactoryGirl.create :course).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:course, name: nil)).not_to be_valid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:course, description: nil)).not_to be_valid
  end

  it "is invalid without a start_date" do
    expect(FactoryGirl.build(:course, start_date: nil)).not_to be_valid
  end

  it "is invalid without a end_date" do
    expect(FactoryGirl.build(:course, end_date: nil)).not_to be_valid
  end

  it "has many lessons" do
    t = Course.reflect_on_association :users
    expect(t.macro).to eq :has_many
  end
end
