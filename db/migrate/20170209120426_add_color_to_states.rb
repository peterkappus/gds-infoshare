class AddColorToStates < ActiveRecord::Migration
  def change
    add_column :states, :color, :string
  end
end
