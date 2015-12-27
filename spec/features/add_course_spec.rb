require "rails_helper"

feature "Add course" do
  subject {page}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let!(:demo_subject){FactoryGirl.create :subject}
  before :each do    
    login_as supervisor, scope: :user
    visit new_supervisor_course_path
  end

  scenario "has title" do
    is_expected.to have_css "h1", text: I18n.t("supervisor.courses.new.title")
  end
  scenario "has name field" do
    is_expected.to have_field "course[name]", type: "text"
  end
  scenario "has description field" do
    is_expected.to have_field "course[description]"
  end
  scenario "has start date field" do
    is_expected.to have_field "course[start_date]", type: "date"
  end
  scenario "has end date field" do
    is_expected.to have_field "course[end_date]", type: "date"
  end
  scenario "has subject field" do
    is_expected.to have_field "course_subject_ids_#{demo_subject.id}", type: "checkbox"
    is_expected.to have_field "course[subject_ids][]", type: "checkbox"
  end
  scenario "has submit button" do
    is_expected.to have_button I18n.t "supervisor.courses.new.bt_new_course"
  end
  scenario "add course feature", js: true do
    fill_in "course[name]", with: Faker::Lorem.word
    fill_in "course[description]", with: Faker::Lorem.paragraph
    select_date Date.tomorrow, from: "sd", datepicker: :bootstrap
    select_date Date.today, from: "ed", datepicker: :bootstrap
    check demo_subject.name
    click_button I18n.t "supervisor.courses.new.bt_new_course"
    is_expected.to have_text I18n.t "flash_course_created"
  end
end