class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :title, :null => false 
      t.text :plot, :null => false
      t.timestamps
    end

    add_reference :episodes, :season, index: true
    add_foreign_key :episodes, :seasons

    #Database fallback: enforce number on season uniqueness
    add_index :episodes, [:number, :season_id], unique: true 
  end
end
