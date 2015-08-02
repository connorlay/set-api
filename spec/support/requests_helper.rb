module RequestsHelper

  def get_with_access_token(path, token, params={}, headers={})
    headers.merge!('Authorization' => token)
    get path, params, headers
  end

  def post_with_access_token(path, token, params={}, headers={})
    headers.merge!('Authorization' => token)
    post path, params, headers
  end

  def put_with_access_token(path, token, params={}, headers={})
    headers.merge!('Authorization' => token)
    put path, params, headers
  end

end
