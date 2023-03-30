json.extract! user, :id, :username, :about, :favorite_quote
json.url user_url(user, format: :json)