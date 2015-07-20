FactoryGirl.define do

  factory :user do
    uid
    name
    image_url
    oauth_token
    access_token
    oauth_expires_at { Time.now + 2.days }
  end

  sequence :uid do |n|
    "#{n}"
  end

  sequence :name do |n|
    "Example User #{n}"
  end

  sequence :image_url do |n|
    "image#{n}.jpg"
  end

  sequence :oauth_token do |n|
    "oauth_token#{n}"
  end

  sequence :access_token do |n|
    "access_token#{n}"
  end

end
