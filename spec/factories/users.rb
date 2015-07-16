FactoryGirl.define do

  factory :user do
    uid              "12345"
    name             "Example User"
    image_url        "some_image.jpg"
    oauth_token      "a_token"
    access_token     "another_token"
    oauth_expires_at { Time.now + 2.days }
  end

end
