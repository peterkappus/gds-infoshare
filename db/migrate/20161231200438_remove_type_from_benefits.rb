class RemoveTypeFromBenefits < ActiveRecord::Migration
  def change
    remove_column :benefits, :type
    #don't do this yet...
    #add_column :benefits, :financial, :boolean, default: true
  end
end
