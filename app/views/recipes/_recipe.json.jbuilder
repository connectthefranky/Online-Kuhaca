json.extract! recipe, :id, :title, :description, :ingredientes, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)