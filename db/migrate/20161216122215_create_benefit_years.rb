class CreateBenefitYears < ActiveRecord::Migration
  def change
    create_table :benefit_years do |t|
      t.date :fy_end_date
      t.integer :target_amount
      t.references :benefit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
