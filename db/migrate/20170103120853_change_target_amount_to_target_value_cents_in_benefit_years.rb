class ChangeTargetAmountToTargetValueCentsInBenefitYears < ActiveRecord::Migration
  def change
    rename_column :benefit_years, :target_amount, :target_value_cents
    #make it long enough for our big numbers...
    change_column :benefit_years, :target_value_cents, :integer, limit: 8
  end
end
