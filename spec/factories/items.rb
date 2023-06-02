FactoryBot.define do
  factory :item do
    title                  { 'タイトル' }
    content                { '説明' }
    category_id            { 3 }
    status_id              { 3 }
    delivery_charge_id     { 3 }
    shipping_origin_id     { 3 }
    date_of_shipment_id    { 3 }
    price                  { 300 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
