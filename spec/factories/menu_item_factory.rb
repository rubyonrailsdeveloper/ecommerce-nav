FactoryGirl.define do
  factory :menu_item, class: Spree::MenuItem do
    name { Faker::Lorem.word }
    url { "http://#{Faker::Internet.domain_name}" }
  end
end
