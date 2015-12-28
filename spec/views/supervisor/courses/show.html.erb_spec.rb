require "rails_helper"

describe "supervisor/courses/show.html.erb" do
  subject {rendered}
  let(:supervisor) {FactoryGirl.build_stubbed :supervisor}
  let(:trainee) {FactoryGirl.build_stubbed :user}
  let(:courses_subject) {FactoryGirl.build_stubbed :courses_subject}
  let(:demo_subject) {FactoryGirl.build_stubbed :subject}
  let!(:english) {FactoryGirl.create :english}
  let!(:activity) {FactoryGirl.create Activity, owner_id: 
    supervisor.id, owner_type: "User", key: "user.create"}
  let(:activities) {PublicActivity::Activity.all}

  before do
    allow(english).to receive(:trainees).and_return [trainee]
    allow(english).to receive(:supervisors).and_return [supervisor]
    allow(english).to receive(:courses_subjects).and_return [courses_subject]
    allow(courses_subject).to receive(:subject).and_return demo_subject
    allow_any_instance_of(PublicActivity::Activity).to receive(:owner).
      and_return supervisor
    
    assign :activities, activities
    assign :course, english
    render
  end

  context "request to supervisor/courses controller and show action" do
    it {expect(controller.request.path_parameters[:controller]).to eq(
      "supervisor/courses")}
    it {expect(controller.request.path_parameters[:action]).to eq "show"}
  end
  
  describe "render" do
    it {is_expected.to have_css "h1", text: english.name}
    it {is_expected.to have_css "p", text: english.description}
    it "All Trainee Title" do      
      is_expected.to have_css "h3", text: I18n.t(
        "supervisor.courses.show.all_trainees")
      within("small") {is_expected.to has_link I18n.t(
        "supervisor.courses.show.hide"), class: "btn btn-info btn-hide", href: 
        "#"}
    end
    it "All Trainee list" do
      # byebug
      within "ol" do
        english.trainees.each do |trainee|
          is_expected.to have_css "li", text: trainee.full_name
        end
      end
    end
    it "All Supervisor Title" do
      is_expected.to have_css "h3", text: I18n.t(
        "supervisor.courses.show.all_supervisors")
      within("small") {is_expected.to has_link I18n.t(
        "supervisor.courses.show.hide"), class: "btn btn-info btn-hide", href: 
        "#"}
    end
    it "All Supervisor list" do
      within "ol" do
        english.supervisors.each do |supervisor|
          is_expected.to have_css "li", text: supervisor.full_name
        end
      end
    end
    it "All Subject Title" do
      is_expected.to have_css "h3", text: I18n.t(
        "supervisor.courses.show.all_subjects")
      within("small") {is_expected.to has_link I18n.t(
        "supervisor.courses.show.hide"), class: "btn btn-info btn-hide", href: 
        "#"}
    end
    it "All Supervisor list" do
      within "ol" do
        english.courses_subjects.each do |courses_subject|
          within "div.row > li" do
            within("div.col-xs-1") {is_expected.to has_link demo_subject.name, 
              id: courses_subject.id, href: 
              edit_supervisor_course_courses_subject_path(course_id: english.id)}
          end          
        end
      end
    end
    it {is_expected.to have_css "h3", text: I18n.t("activity_log")}
    it "Activity list" do
      is_expected.to have_css "table.table"
      activities.each do |activity|
        within "tr > td" do
          is_expected.to has_css "b.text-capitalize", text: english.name
          message = "created by " + supervisor.full_name + 
            time_ago_in_words(activity.created_at).gsub("about","") + I18n.t(:ago)
          is_expected.to has_text message          
        end
      end
    end
  end
end