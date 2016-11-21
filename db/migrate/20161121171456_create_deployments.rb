class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.references :portfolio, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true
      t.references :organisation, index: true, foreign_key: true
      t.string :location
      t.string :tech_layer
      t.text :existing_solution
      t.text :alternative_solution
      t.text :cts_solution
      t.string :benefit_type
      t.string :state
      t.text :comments

      t.timestamps null: false
    end
  end
end
