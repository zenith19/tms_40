require "rails_helper"

describe "supervisor/courses/index.html.erb" do
  subject {rendered}
  let(:search) {Course.all.ransack}
  let(:courses) {search.result.paginate page: params[:page], per_page: 10}

  before do
    FactoryGirl.create :course
    courses.each do |course|
      allow(course).to receive(:to_partial_path).and_return(
        "supervisor/courses/course")
    end
    assign :search, search
    assign :courses, courses
    assign :test, courses
    render
  end

  context "request to supervisor/courses controller and index action" do
    it {expect(controller.request.path_parameters[:controller]).to eq(
      "supervisor/courses")}
    it {expect(controller.request.path_parameters[:action]).to eq "index"}
  end
  
  describe "render" do
    it "search form" do
      is_expected.to have_selector "form" do |f|
        is_expected.to have_selector "input", value: "q[name_cont]"
        is_expected.to have_selector "input", type: "submit"
      end
    end
    context "courses list" do      
      it {is_expected.to have_css "table.table-stripped"}
      it "has table header" do
        within "thead" do
          is_expected.to have_css "th", text: I18n.t(:name)
          is_expected.to have_css "th", text: I18n.t(:description)
          is_expected.to have_css "th", text: I18n.t(:start_date)
          is_expected.to have_css "th", text: I18n.t(:end_date)
          is_expected.to have_css "th", text: I18n.t(:supervisors)
          is_expected.to have_css "th", text: I18n.t(:trainees)
          is_expected.to have_css "th", text: I18n.t(:action)
        end
      end
      it "has table body" do
        within "tbody" do
          courses.each do |course|
            within "tr" do
              within("td") {is_expected.to has_link course.name}
              is_expected.to have_css "td", text: course.start_date
              is_expected.to have_css "td", text: course.end_date
              is_expected.to have_css "td", text: course.supervisors.count
              is_expected.to have_css "td", text: course.trainees.count
            end
          end
        end
      end
    end
    it "render template in index" do
      expect(response).to render_template "courses/_course"
    end
  end
end
