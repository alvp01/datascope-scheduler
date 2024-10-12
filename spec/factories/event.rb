FactoryBot.define do
  factory :event do
    start_time { Time.current }
    end_time { 1.hours.after(start_time) }
    location { Faker::Internet.domain_name }
    association :user, factory: :user
  end
end
