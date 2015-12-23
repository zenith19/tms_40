require "faker"

FactoryGirl.define do
  factory :users_subject do |f|
    user
    courses_subject
    finished true
  end
end
