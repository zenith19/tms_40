require "rails_helper"

feature "Start course" do
  subject {page}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let!(:course){FactoryGirl.create :course, user_ids: [supervisor.id]}
  before :each do
    login_as supervisor, scope: :user
    visit supervisor_course_path course
  end

  scenario "has update status field" do
    is_expected.to have_selector "input#course_update_status", visible: false
  end  
  scenario "has submit button" do
    is_expected.to have_button I18n.t "supervisor.courses.show.start"
  end
  scenario "edit course feature", js: true do    
    click_button I18n.t "supervisor.courses.show.start"
    is_expected.to have_text I18n.t("supervisor.courses.update.success", action: 
      "Started")
  end
end