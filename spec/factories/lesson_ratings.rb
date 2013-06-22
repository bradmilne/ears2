# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_rating do
    rating "MyString"
    user_id 1
    lesson_id 1
  end
end
