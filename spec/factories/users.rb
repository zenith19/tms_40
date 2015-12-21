require "faker"

FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {Faker::Internet.password 8}

    User.roles.each_key do |key|
      factory "#{key}" do
        role {User.roles[key]}
      end
    end

    factory :trainee_with_created_course, aliases: [:user_with_created_course] do
      courses {[FactoryGirl.create(:created_course)]}
    end

    factory :trainee_with_started_course, aliases: [:user_with_started_course] do
      courses {[FactoryGirl.create(:started_course)]}
    end

    factory :trainee_with_finished_course, aliases: [:user_with_finished_course] do
      courses {[FactoryGirl.create(:finished_course)]}
    end
  end
end