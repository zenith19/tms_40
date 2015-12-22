require "faker"

FactoryGirl.define do
  factory :course do |f|
    f.name {Faker::Lorem.word}
    f.description {Faker::Lorem.paragraph}
    f.start_date {Faker::Date.backward 23}
    f.end_date {Faker::Date.forward 23}
  end
end