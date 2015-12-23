require "rails_helper"

describe UsersSubject do
  it {is_expected.to be_an UsersSubject}
  it {expect belong_to :user}
  it {expect belong_to :courses_subject}
  it {expect belong_to :subject}

  describe ".find_by_user" do
    let(:user) {FactoryGirl.create :user}
    let!(:users_subject) {FactoryGirl.create :users_subject}
    let!(:users_subject2) {FactoryGirl.create :users_subject}

    context "find users_subject for specific trainee" do
      subject {UsersSubject.find_by_user users_subject.user_id}
      it {is_expected.to be_an UsersSubject}
    end
    
    context "no users_subject from UsersSubject" do
      subject {UsersSubject.find_by_user user.id}
      it {is_expected.not_to be_an UsersSubject}
    end
  end
end
