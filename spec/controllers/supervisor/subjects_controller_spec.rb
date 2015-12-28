require "rails_helper"

describe Supervisor::SubjectsController do
  let(:user){FactoryGirl.create :user}
  let(:subject) {double Subject}
  let(:supervisor) {FactoryGirl.create :supervisor}
  before{sign_in user}

  before do
    allow(request.env["warden"]).to receive(:authenticate!).and_return(
      supervisor)
    allow(Subject).to receive(:new).and_return subject
    allow_any_instance_of(CanCan::ControllerResource).to receive(
      :load_and_authorize_resource)
  end

  describe "GET index" do
    before {get :index}
    let(:subject){FactoryGirl.create :subject}
    context "Get index successfully" do
      it {expect(response).to be_success}
      it {expect(response).to render_template :index}
      it {expect(response).to have_http_status :ok}
      it "populates list of subjects" do
        expect(assigns(:subjects)).to include subject
      end
    end
  end

  describe "GET new" do
    let(:tasks) {Task.all}
    before do
      allow(subject).to receive(:tasks).and_return tasks
      get :new
    end
    it {expect(assigns :subject).to be subject}
    it {expect(response).to render_template :new}
  end

  describe "POST create" do
    let(:input) {Subject.new}
    before do
      allow(subject).to receive(:save).and_return true
      post :create, subject: {name: input}
    end

    it {expect(assigns :subject).to be subject}

    context "with valid attributes create the subject" do
      it {expect(response).to redirect_to supervisor_subjects_path}
    end

    context "with invalid attributes" do
      before do
        allow(subject).to receive(:save).and_return false
        post :create, subject: {name: input}
      end
      it {expect(response).to render_template :new}
    end
  end

  describe "GET edit" do
    let(:subject){Subject.first}
    before do
      allow(Subject).to receive(:find).and_return subject
      get :edit, id: subject.id
    end

    it {expect(response).to be_success}
    it {expect(response).to have_http_status :ok}
    it {expect(response).to render_template :edit}
  end

  describe "POST update" do
    let(:subject){Subject.first}
    before do
      allow(Subject).to receive(:find).and_return subject
      allow(subject).to receive(:update_attributes).and_return true
      put :update, {id: subject, subject: {name: "Subject1"}}
    end

    it {expect(assigns :subject).to be subject}

    context "with valid attributes update the subject" do
      it {expect(response).to redirect_to supervisor_subjects_path}
    end

    context "with invalid attributes" do
      before do
        allow(subject).to receive(:update_attributes).and_return false
        put :update, {id: subject, subject: {name: "Subject1"}}
      end
      it {expect(response).to render_template :edit}
    end
  end
end
