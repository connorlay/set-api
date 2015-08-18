FactoryGirl.define do

  factory :game do
    lobby
    deck  (0...81).to_a
    board []
  end

end
