require "faker"

FactoryGirl.define do
  factory :courses_subject do |f|
    courses
    subjects
  end
end