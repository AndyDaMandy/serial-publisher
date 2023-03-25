json.extract! story, :id, :title, :description, :user_id, :created_at, :updated_at
json.url story_url(story, format: :json)
