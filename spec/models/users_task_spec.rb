require "rails_helper"

describe UsersTask do
  subject {FactoryGirl.create :users_task}
  it {is_expected.to be_an UsersTask}
  it {expect validate_presence_of :user_id}
  it {expect validate_presence_of :task_id}

  it {expect belong_to :user}
  it {expect belong_to :task}

  describe ".find_task_id" do
    let(:users_task) {FactoryGirl.create :users_task}
    subject {UsersTask.find_task_id users_task.user.id, users_task.task.id}

    context "find user_task_id from UsersTask" do
      it {expect respond_to :find_task_id}
    end
  end
end
