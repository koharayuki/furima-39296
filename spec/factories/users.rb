FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    last_name             { japanese_user.last.kanji }
    first_name            { japanese_user.first.kanji }
    suv_last_name         { japanese_user.last.katakana }
    suv_first_name        { japanese_user.first.katakana }
    date_of_birth         { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
