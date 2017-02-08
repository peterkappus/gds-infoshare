class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :position
      t.text :description

      t.timestamps null: false
    end

    #remove old state column
    remove_column :benefits, :state

    #add new state_id reference column
    add_column :benefits, :state_id, :integer

  end
end
