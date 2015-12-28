require "rails_helper"

feature "Destroy course" do
  subject {page}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let!(:course){FactoryGirl.create :course, user_ids: [supervisor.id]}
  before :each do
    course.finished!
    login_as supervisor, scope: :user
    visit supervisor_courses_path
  end

  scenario "has delete button" do
    Course.finished.each do |course|
      is_expected.to have_link(I18n.t("supervisor.courses.course.delete"), href: 
        "/supervisor/courses/#{course.id}")
    end
  end
  
  scenario "destroy course feature", js: true do    
    click_link(I18n.t("supervisor.courses.course.delete"), href: 
      "/supervisor/courses/#{course.id}")
    sleep 3
    page.driver.browser.switch_to.alert.accept
    is_expected.to have_text I18n.t "supervisor.courses.destroy.course_delete"
  end
end