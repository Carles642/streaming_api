class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.integer :number, :null => false
      t.string :title, :null => false 
      t.text :plot, :null => false
      t.timestamps
    end
  end
end
