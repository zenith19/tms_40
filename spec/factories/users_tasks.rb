require "faker"

FactoryGirl.define do
  factory :users_task do
    user
    task
  end
end
