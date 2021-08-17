FactoryBot.define do
  factory :item do
    product_name       { 'hoge' }
    description        { Faker::Lorem.sentence }
    category_id        { 2 }
    status_id          { 2 }
    delivery_charge_id { 2 }
    delivery_area_id   { 2 }
    delivery_day_id    { 2 }
    price              { 1000 }
    user_id            { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
