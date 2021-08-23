FactoryBot.define do
  factory :purchase_residence do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_num { '09012345678' }
    user_id { 2 }
    item_id { 2 }
    association :item
    user { item.user }
    token {"tok_abcdefghijk00000000000000000"}
  end
end