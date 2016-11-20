json.extract! person, :id, :name, :portfolio_id, :created_at, :updated_at
json.url person_url(person, format: :json)