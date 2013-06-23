# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_rating do
    rating "MyString"
    user_id 1
    question_id 1
  end
end
