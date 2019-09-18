FactoryBot.define do
    factory :content do
        content_type 'h1'
        content_value { Faker::Lorem.word }
        webpage_id nil
    end
end