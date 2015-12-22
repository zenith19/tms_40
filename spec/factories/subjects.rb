require "faker"

FactoryGirl.define do
  factory :subject do |f|
    f.name {Faker::Lorem.word}
    f.description {Faker::Lorem.paragraph}
  end
end
