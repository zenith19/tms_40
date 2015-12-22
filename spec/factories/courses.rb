require "faker"

FactoryGirl.define do
  factory :course do
    name {Faker::Lorem.word}
    description {Faker::Lorem.paragraph}
    start_date {Faker::Date.backward}
    end_date {Faker::Date.forward}

    Course.statuses.each_key do |key|
      factory "#{key}_course" do
        status {Course.statuses[key]}
      end      
    end
  end
end