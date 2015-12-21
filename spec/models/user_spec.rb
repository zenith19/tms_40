require "rails_helper"

describe User do
  subject {FactoryGirl.create :user}
  it {is_expected.to be_an User}
  it {expect validate_presence_of :first_name}
  it {expect validate_presence_of :last_name}
  it {expect validate_presence_of :email}
  it {expect validate_presence_of :password}
  it {expect validate_uniqueness_of :email}
  it {expect have_many :activities}
  it {expect have_many :users_courses}
  it {expect have_many :courses}
  it {expect have_many :users_subjects}
  it {expect have_many :courses_subjects}
  it {expect have_many :subjects}
  it {expect have_many :users_tasks}
  it {expect have_many :tasks}

  describe ".free" do
    subject {User.free}

    context "includes users with created courses" do
      it {is_expected.to include FactoryGirl.create :user_with_created_course}
    end

    context "includes users with started courses" do
      it {is_expected.to include FactoryGirl.create :user_with_started_course}
    end

    context "does not include users with finished courses" do
      it {is_expected.not_to include FactoryGirl.create :user_with_finished_course}
    end
  end

  describe ".assignable_trainees" do
    let(:course) {FactoryGirl.create :course}
    subject {User.assignable_trainees course}

    context "includes trainees of passed course" do
      it {is_expected.to include FactoryGirl.create :user, courses: [course]}
    end

    context "does not include supervisor" do
      it {is_expected.not_to include FactoryGirl.create :supervisor}
    end

    context "does include trainees with finished other courses" do
      it {is_expected.to include FactoryGirl.create :user_with_finished_course}
    end
  end

  describe "#full_name" do
    let(:user) {FactoryGirl.create :user}
    subject {user.full_name}

    context "includes first_name" do
      it {is_expected.to include user.first_name}
    end

    context "includes last_name" do
      it {is_expected.to include user.last_name}
    end

    context "includes a space" do
      it {is_expected.to include " "}
    end

    context "joins first_name and last_name while first_name comes first" do
      it {is_expected.to eq user.first_name + " " + user.last_name}
    end
  end
end