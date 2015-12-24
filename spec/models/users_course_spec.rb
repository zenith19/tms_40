require "rails_helper"

describe UsersCourse do
  let(:demo_obj) {FactoryGirl.build :users_course}
  subject {FactoryGirl.create :users_course}  

  it {is_expected.to be_an UsersCourse}
  it {expect belong_to :user}
  it {expect belong_to :course}

  it "triggers .appened_assigned_users on save" do
    expect(demo_obj).to receive :appened_assigned_users
    demo_obj.save
  end

  it "triggers .appened_removed_users on destroy" do
    demo_obj.save
    expect(demo_obj).to receive :appened_removed_users
    demo_obj.destroy
  end

  it {expect(demo_obj.course.assigned_users).not_to include demo_obj.user}
  context "checking callbacks internal functionality" do
    before {demo_obj.save}
    
    it {expect(demo_obj.course.assigned_users).to include demo_obj.user}
    it "appened_removed_users" do
      demo_obj.destroy
      expect(demo_obj.course.assigned_users).to include demo_obj.user
    end
  end
end