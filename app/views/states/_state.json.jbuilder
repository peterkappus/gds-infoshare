json.extract! state, :id, :name, :position, :description, :created_at, :updated_at
json.url state_url(state, format: :json)