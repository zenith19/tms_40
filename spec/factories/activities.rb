require "faker"

FactoryGirl.define do
  factory :activity do
    key {"course.create"}
    created_at {Faker::Date.backward}
  end
end