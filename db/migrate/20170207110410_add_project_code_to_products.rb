class AddProjectCodeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :project_code, :string
  end
end
