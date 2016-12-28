class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :reference
      t.string :source
      t.references :department, index: true, foreign_key: true
      t.string :supplier_name
      #t.string :value
      t.date :end_date
      t.references :organisation, index: true, foreign_key: true
      t.string :project
      t.string :product
      t.bigint :value_cents
      t.date :start_date
      t.float :years
      t.string :sector
      t.bigint :annual_value_cents
      t.string :category
      t.string :sub_contractors
      t.text :notes
      t.string :status
      t.integer :year_awarded

      t.timestamps null: false
    end
  end
end
