class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      #nope, use key on portfolio table instead
      #t.references :portfolio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
