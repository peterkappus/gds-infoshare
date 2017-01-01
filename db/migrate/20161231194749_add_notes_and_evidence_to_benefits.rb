class AddNotesAndEvidenceToBenefits < ActiveRecord::Migration
  def change
    add_column :benefits, :notes, :text
    add_column :benefits, :evidence, :text
  end
end
