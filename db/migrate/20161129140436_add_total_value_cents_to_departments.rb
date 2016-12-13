class AddTotalValueCentsToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :total_value_cents, :bigint
  end
end
