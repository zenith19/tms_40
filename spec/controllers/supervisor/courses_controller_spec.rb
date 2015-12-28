require "rails_helper"

describe Supervisor::CoursesController do
  let(:course) {double Course}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let!(:english) {FactoryGirl.create :english}
  let!(:vietnamese) {FactoryGirl.create :vietnamese}

  before do
    allow(request.env["warden"]).to receive(:authenticate!).and_return(
      supervisor)
    allow(Course).to receive(:new).and_return course
    allow_any_instance_of(CanCan::ControllerResource).to receive(
      :load_and_authorize_resource)
  end

  describe "GET index" do
    before do
      allow(controller).to receive(:current_user).and_return supervisor
      allow(supervisor).to receive(:supervisor?).and_return true
      allow(supervisor).to receive(:courses).and_return Course.all
      get :index
    end

    context "get index successfully" do
      let(:var_search) {Course.all.search first_name_cont: ""}

      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(assigns(:courses)).to eq(var_search.result.paginate page: 1, 
          per_page: 10)}
      it {expect(response).to render_template :index}
    end
  end

  describe "GET new" do
    before {get :new}

    context "get new successfully" do      
      it {expect(assigns :course).to be course}
      it {expect(response).to render_template :new}
    end
  end

  describe "POST create" do
    let(:input) {Course.new}
    
    before do
      allow(course).to receive(:save).and_return true
      post :create, course: {name: input}
    end

    it {expect(assigns :course).to be course}

    context "when course saved successfully" do
      it {expect(flash[:notice]).to eq I18n.t :flash_course_created}
      it {expect(response).to redirect_to supervisor_course_path course}
    end
    context "when the course failed to save" do
      before do
        allow(course).to receive(:save).and_return false
        post :create, course: {name: input}
      end

      it {expect(response).to render_template :new}
    end
  end

  describe "GET show" do
    let(:activities) {Activity.all}

    before do
      allow(Course).to receive(:find).and_return vietnamese
      allow(vietnamese).to receive(:load_activities).and_return activities
      get :show, id: vietnamese
    end

    it {expect(response).to be_success}
    it {expect(response).to have_http_status 200}
    it {expect(assigns :course).to be vietnamese}
    it {expect(assigns :activities).to be activities}
    it {expect(response).to render_template :show}
  end

  describe "GET edit" do
    before do
      allow(Course).to receive(:find).and_return english
      get :edit, id: english
    end

    it {expect(response).to be_success}
    it {expect(response).to have_http_status 200}
    it {expect(assigns :course).to be english}
    it {expect(response).to render_template :edit}
  end

  describe "PUT update" do
    before {allow(Course).to receive(:find).and_return course}

    context "when course successed .check_course" do
      before do
        allow(course).to receive(:update_attributes).and_return true
        allow(course).to receive(:invalid_for_update?).and_return false
        allow(course).to receive(:to_model).and_return english      
        put :update, {id: english, course: {name: "bengali"}}
      end

      it {expect(assigns :course).to be course}

      context "when the request is to update the course info" do
        context "when the course updated successfully" do
          it {expect(response).to redirect_to supervisor_course_path course}
        end
        context "when the course failed to update" do
          before do
            allow(course).to receive(:update_attributes).and_return false
            put :update, {id: english, course: {name: "bengali"}}
          end

          it {expect(response).to render_template :edit}
        end
      end
      context "when request is to start or finish the course" do
        before do
          allow(course).to receive :update_status!
          allow(course).to receive(:started?).and_return true
        end
        context "when course start" do
          before {put :update, {id: english, course: {name: "bengali", 
            update_status: ""}}}
          it {expect(flash[:success]).to eq I18n.t(
            "supervisor.courses.update.success", action: "Started")}
          it {expect(response).to redirect_to supervisor_course_path course}
        end
        context "when course finish" do
          before do
            allow(course).to receive(:started?).and_return false
            put :update, {id: english, course: {name: "bengali", update_status: 
              ""}}            
          end
          it {expect(flash[:success]).to eq I18n.t(
            "supervisor.courses.update.success", action: "Finished")}
          it {expect(response).to redirect_to supervisor_course_path course}
        end
      end
    end
    context "while course failed .check_course" do
      before do
        allow(course).to receive(:invalid_for_update?).and_return true
        put :update, {id: english, course: {name: "bengali"}}
      end

      it {expect(flash[:danger]).to eq I18n.t "supervisor.courses.update.danger"}
      it {expect(assigns :course).to redirect_to supervisor_courses_path}
    end
  end

  describe "DELETE destroy" do
    let!(:num_of_courses) {Course.count}

    before {delete :destroy, {id: english, course: english.attributes}}

    context "delete successfully" do
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to supervisor_courses_path}
      it {expect(flash[:success]).to eq I18n.t(
          "supervisor.courses.destroy.course_delete")}
      it {expect(Course.count).to eq(num_of_courses - 1)}
    end
  end
end