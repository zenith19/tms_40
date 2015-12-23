require "rails_helper"

describe UsersTask do
  subject {FactoryGirl.create :users_task}
  it {is_expected.to be_an UsersTask}
  it {expect belong_to :user}
  it {expect belong_to :task}

  describe ".find_task_id" do
    let!(:user) {FactoryGirl.create :user}
    let!(:task) {FactoryGirl.create :task}
    let!(:users_task1) {FactoryGirl.create :users_task}

    context "user_task obj using users_task1" do
      subject {UsersTask.find_task_id users_task1.user_id, users_task1.task_id}
      it {is_expected.to be_an UsersTask}
    end

    context "no user_task obj using user and task" do
      subject {UsersTask.find_task_id user, task}
      it {is_expected.not_to be_an UsersTask}
    end
  end
end
