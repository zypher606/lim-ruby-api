FactoryBot.define do
    factory :webpage do
        url { 'http://' + Faker::Lorem.word + ".com" }
   
    end
end