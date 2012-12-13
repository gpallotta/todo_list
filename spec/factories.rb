FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { "user#{n}@user.com" }
    password 'foobar'
    password_confirmation 'foobar'

  end

  factory :task do
    title 'test title'
    user
    done false

    factory :done do
      title 'done task'
      done true
    end
  end
end
