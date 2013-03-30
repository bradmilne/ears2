# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    lesson_id 1
    question "MyString"
    answer "MyString"
    octave 1
  end
end
