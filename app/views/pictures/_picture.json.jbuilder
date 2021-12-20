json.extract! picture, :id, :title, :content, :user_id, :created_at, :updated_at
json.url blog_url(picture, format: :json)
