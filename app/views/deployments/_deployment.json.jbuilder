json.extract! deployment, :id, :portfolio_id, :person_id, :department_id, :organisation_id, :location, :tech_layer, :existing_solution, :alternative_solution, :cts_solution, :benefit_type, :state, :comments, :created_at, :updated_at
json.url deployment_url(deployment, format: :json)