FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 6)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name             {"鈴木"}
    first_name            {"たろう"}
    last_name_kana        {"スズキ"}
    first_name_kana       {"タロウ"}
    birthday              {"2000-01-01"}
  end
end