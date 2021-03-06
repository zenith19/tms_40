require "rails_helper"

describe UsersController do
  let(:user){FactoryGirl.create :user}
  before{sign_in user}

  describe "GET index" do
    before {get :index}
    context "Get index successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status :ok}
      it {expect(response).to render_template :index}
    end
    it "populates list of users" do
      expect(assigns(:users)).to include user
    end
  end

  describe "GET #show" do
    context "Get Show successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status :ok}
      it "renders the :show template" do
        get :show, id: user
        expect(response).to render_template :show
      end
    end
  end

  describe "PUT #update" do
    before {allow(User).to receive(:find).and_return user}
    context "succesful update" do
      before do
        allow(user).to receive(:update_attributes).and_return true
        put :update, {id: user, user: {name: "Test1"}}
      end
      it {expect(response).to redirect_to edit_courses_subject_path}
    end
    context "update failure" do
      before do
        allow(user).to receive(:update_attributes).and_return false
        put :update, {id: user, user: {name: "Test1"}}
      end
      it {expect(response).to render_template "courses_subjects/edit"}
    end
  end
end
