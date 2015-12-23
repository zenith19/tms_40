require "faker"

FactoryGirl.define do
  factory :task do
    name {Faker::Lorem.word}
    subject
  end
end
