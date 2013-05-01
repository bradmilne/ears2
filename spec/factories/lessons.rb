# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title "Sample Lesson"
    description "A sample lesson for everyone that wants to learn"
    category "Ear Training"
  end
end
