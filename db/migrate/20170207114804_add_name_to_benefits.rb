class AddNameToBenefits < ActiveRecord::Migration
  def change
    add_column :benefits, :name, :string
  end
end
