FactoryGirl.define do
  factory :user do
    name 'Greg'
    email 'crap@crap.com'
    password 'foobar'
    password_confirmation 'foobar'

  end

  factory :task do
    title 'test title'
    user
  end
end
