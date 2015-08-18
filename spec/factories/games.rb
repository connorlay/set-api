FactoryGirl.define do

  factory :game do
    lobby
    deck  (0...81).to_a
    board []

    trait :active do
      status 0
    end

    trait :finished do
      status 1
    end
  end

end
