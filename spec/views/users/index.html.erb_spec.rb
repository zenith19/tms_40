require "rails_helper"

describe "users/index.html.erb" do
  subject {rendered}
  let(:search) {User.all.ransack}
  let(:users) {search.result.paginate page: params[:page], per_page: 10}

  before do
    FactoryGirl.create :user
    users.each do |user|
      allow(user).to receive(:to_partial_path).and_return "index"
    end
    assign :search, search
    assign :users, users
    assign :test, users
    render
  end

  describe "render" do
    it "search form" do
      is_expected.to have_selector "form" do |f|
        is_expected.to have_selector "input", value: "q[name_cont]"
        is_expected.to have_selector "input", type: "submit"
      end
    end
    
    context "users list" do
      it {is_expected.to have_css "table.table-striped"}
      it "has table header" do
        within "thead" do
          is_expected.to have_css "th", text: Name
          is_expected.to have_css "th", text: Email
        end
      end
      it "has table body" do
        within "tbody" do
          users.each do |user|
            within "tr" do
              within("td") {is_expected.to has_link user.full_name}
              within("td") {is_expected.to have_css "td", text: user.email}
            end
          end
        end
      end
    end

    it "render template in index" do
      expect(response).to render_template :index
    end
  end

  context "request to users controller and index action" do
    it {expect(controller.request.path_parameters[:controller]).to eq("users")}
    it {expect(controller.request.path_parameters[:action]).to eq "index"}
  end
end
