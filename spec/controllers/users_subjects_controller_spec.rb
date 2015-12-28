require "rails_helper"
describe UsersSubjectsController do
  let(:trainee) {FactoryGirl.create :user}
  let(:users_subject) {FactoryGirl.create :users_subject}

  before do
    allow(request.env["warden"]).to receive(:authenticate!).and_return(
      trainee)
    allow(UsersSubject).to receive(:new).and_return users_subject
  end

  describe "POST create" do
    let(:user_subject_attributes) {FactoryGirl.attributes_for(:users_subject)}
    before do
      allow(users_subject).to receive(:save).and_return true
      post :create, users_subject: user_subject_attributes
    end

    it {expect(assigns :users_subject).to be users_subject}

    context "with valid attributes create UsersSubject" do
      let!(:course_subject_id) {users_subject.courses_subject_id}
      it {expect(response).to redirect_to edit_courses_subject_path(
        course_subject_id)}
    end

    context "with invalid attributes redirect to courses_subjects" do
      before do
        allow(users_subject).to receive(:save).and_return false
        post :create, users_subject: user_subject_attributes
      end
      it {expect(response).to render_template "courses_subjects/edit"}
    end
  end
end
