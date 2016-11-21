class AddCtsInitiativeToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :cts_initiative, :string
  end
end
