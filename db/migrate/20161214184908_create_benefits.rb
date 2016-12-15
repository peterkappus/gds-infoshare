class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.references :department, index: true, foreign_key: true
      t.references :organisation, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.string :location
      t.text :original_offering
      t.text :non_cts_alternative
      t.text :cts_proposal
      t.integer :type
      t.integer :state

      t.timestamps null: false
    end
  end
end
