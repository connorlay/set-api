RSpec.shared_context "a response with user data" do

  it "responds with user data" do
    user_data = json['data']
    expect(user_data['type']).to                    eq "users"
    expect(user_data['attributes']['name']).to      eq user.name
    expect(user_data['attributes']['image_url']).to eq user.image_url
  end

end

RSpec.shared_context "a response with game data" do

  it "responds with game data" do
    expect(json['data']['type']).to eq "games"
  end

  it "responds with board data" do
    expect(json['data']['attributes']).to have_key("board")
  end

end

RSpec.shared_context "a response with lobby data" do

  it "responds with lobby data" do
    expect(json['data']['type']).to eq "lobbies"
    expect(json['data']['relationships']).to include "users"
  end

end
