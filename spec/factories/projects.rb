FactoryGirl.define do
  factory :project do
    customer
    brand
    name "MyString"
    description "MyText"
    delivery_deadline Date.today
    notes "My Text"
    rush_job false

    trait :quoted do
      status 0
    end

    trait :sold do
      status 1
    end

    trait :finalised do
      status 2
      finalised_at { Date.today }
    end

    trait :completed do
      status 3
      finalised_at { 3.days.ago }
      completed_at { Date.today }
    end

    trait :archived do
      status 4
    end

    factory :quoted_project, traits: [:quoted]
    factory :sold_project, traits: [:sold]
    factory :finalised_project, traits: [:finalised]
    factory :completed_project, traits: [:completed]
    factory :archived_project, traits: [:archived]
  end

end
