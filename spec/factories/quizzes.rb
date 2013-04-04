# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    score "9.99"
    lesson_id 1
    user_id 1
  end
end
