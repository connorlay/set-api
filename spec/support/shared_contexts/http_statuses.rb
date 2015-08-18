RSpec.shared_context "a successfull response" do

  it "returns an 200 status code" do
    expect(response).to have_http_status 200
  end

end

RSpec.shared_context "an existance error" do

  it "returns a 404 status code" do
    expect(response).to have_http_status 404
    expect(json['error']).to eq I18n.t('errors.404')
  end

end

RSpec.shared_context "a conflict error" do

  it "returns a 409 status code" do
    expect(response).to have_http_status 409
    expect(json['error']).to eq I18n.t('errors.409')
  end

end

RSpec.shared_context "an authorization error" do

  it "returns a 401 status code" do
    expect(response).to have_http_status 401
    expect(json['error']).to eq I18n.t('errors.401')
  end

end

RSpec.shared_context "a redirection" do

  it "returns an 302 status code" do
    expect(response).to have_http_status 302
  end

end
