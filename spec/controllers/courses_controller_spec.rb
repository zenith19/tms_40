require "rails_helper"

describe CoursesController do
  describe "GET show" do
    let(:trainee) {FactoryGirl.create :user}
    let(:english) {double Course}
    let(:courses) {[english]}
    let(:activities) {Activity.all}
    
    before do
        PublicActivity.enabled = false
      allow(request.env["warden"]).to receive(:authenticate!).and_return(
        trainee)    
      allow_any_instance_of(CanCan::ControllerResource).to receive(
        :load_and_authorize_resource)
      allow(controller).to receive(:current_user).and_return trainee
      allow(trainee).to receive(:courses).and_return courses
      allow(english).to receive(:load_acitvities).and_return activities
      get :show, id: english
    end

    it {expect(response).to be_success}
    it {expect(response).to have_http_status 200}
    it {expect(assigns :course).to be english}
    it {expect(assigns :activities).to be activities}
    it {expect(response).to render_template :show}
  end
end