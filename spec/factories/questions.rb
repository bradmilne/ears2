# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    lesson_id 1
    question "What do you hear?"
    answer "Major 3rd"
    octave 1
  end
end
