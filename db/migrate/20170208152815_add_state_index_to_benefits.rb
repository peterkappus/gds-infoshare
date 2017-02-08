class AddStateIndexToBenefits < ActiveRecord::Migration
  def change
    add_index :benefits, :state_id
  end
end
