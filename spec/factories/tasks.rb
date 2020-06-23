FactoryBot.define do
  factory :task do
    title { "MyString" }
    start { "2020-06-23 17:02:08" }
    duration { 1 }
    description { "MyText" }
  end
end
