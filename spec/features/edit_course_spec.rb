require "rails_helper"

feature "Edit course" do
  subject {page}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let!(:demo_subject){FactoryGirl.create :subject}  
  let!(:course){FactoryGirl.create :course, subject_ids: [demo_subject.id], 
    user_ids: [supervisor.id]}
  before :each do
    login_as supervisor, scope: :user
    visit edit_supervisor_course_path course
  end

  scenario "has title" do
    is_expected.to have_css "h1", text: I18n.t("supervisor.courses.edit.title")
  end
  scenario "has name field" do
    is_expected.to have_field "course[name]", type: "text", with: course.name
  end
  scenario "has description field" do
    is_expected.to have_field "course[description]", text: course.description
  end
  scenario "has start date field" do
    is_expected.to have_field "course[start_date]", type: "date", with: 
      course.start_date.strftime("%d/%m/%Y")
  end
  scenario "has end date field" do
    is_expected.to have_field "course[end_date]", type: "date", with: 
      course.end_date.strftime("%d/%m/%Y")
  end
  scenario "has subject field" do
    subject_ids = course.subject_ids
    Subject.ids.each do |id|
      if subject_ids.include? id
        is_expected.to have_checked_field "course_subject_ids_#{id}"
      else
        is_expected.to have_unchecked_field "course_subject_ids_#{id}"
      end
    end
  end
  scenario "has submit button" do
    is_expected.to have_button I18n.t "supervisor.courses.edit.submit"
  end
  scenario "edit course feature", js: true do
    fill_in "course[name]", with: Faker::Lorem.word
    fill_in "course[description]", with: Faker::Lorem.paragraph
    select_date Date.tomorrow, from: "sd", datepicker: :bootstrap
    uncheck demo_subject.name
    click_button I18n.t "supervisor.courses.edit.submit"
    is_expected.to have_text I18n.t("supervisor.courses.update.success", action: 
      "Updated")
  end
end