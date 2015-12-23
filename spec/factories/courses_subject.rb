require "faker"

FactoryGirl.define do
  factory :courses_subject do |f|
    course
    subject
  end
end