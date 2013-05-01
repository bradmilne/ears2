# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
    user_answer "Major 3rd"
    correct_answer "Major 3rd"
    result "Correct"
    octave 1
    lesson_id 1
    user_id 1
  end
end
