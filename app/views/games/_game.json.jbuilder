json.extract! game, :id, :name, :review, :rating, :created_at, :updated_at
json.url game_url(game, format: :json)
