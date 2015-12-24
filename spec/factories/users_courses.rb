require "faker"

FactoryGirl.define do
  factory :users_course do
    user
    course
  end
end
