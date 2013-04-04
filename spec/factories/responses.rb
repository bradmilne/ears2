# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
    user_answer "MyString"
    correct_answer "MyString"
    result "MyString"
    octave 1
    lesson_id 1
    user_id 1
  end
end
