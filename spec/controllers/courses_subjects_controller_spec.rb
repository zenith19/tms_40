require "rails_helper"

describe CoursesSubjectsController do
  let(:user){FactoryGirl.create :user}
  before do
    allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
  end

  describe "Get Edit" do
    let(:courses_subject){FactoryGirl.create :courses_subject}
    let(:users_subject) {FactoryGirl.create :users_subject}
    before do
      allow(CoursesSubject).to receive(:find).and_return courses_subject
      get :edit, id: courses_subject.id
    end
    it {expect(response).to be_success}
    it {expect(response).to have_http_status :ok}
    it {expect(response).to render_template :edit}
    it {expect(assigns :courses_subject).to be courses_subject}
    it "returns a users_subject" do
      courses_subject.stub_chain(:users_subjects, :find_by).with(user).and_return users_subject
    end
  end
end
