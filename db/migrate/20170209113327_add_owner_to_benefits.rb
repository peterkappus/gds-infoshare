class AddOwnerToBenefits < ActiveRecord::Migration
  def change
    add_column :benefits, :owner, :string
  end
end
