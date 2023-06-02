FactoryBot.define do
  factory :order_delivery do
    post_code { '123-4567' }
    shipping_origin_id { 2 }
    city { '長崎市' }
    brock { '1-1' }
    building { '長崎ハイツ' }
    phone_number { 11_111_111_111 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
