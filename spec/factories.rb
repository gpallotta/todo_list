FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { "user#{n}@user.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :task do
    sequence(:title) { |n| "title_#{n}" }
    user
  end
end
