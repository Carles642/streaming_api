class CreatePurchaseOpts < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_opts do |t|
      t.integer :product_id, :null => false
      t.string :product_type, :null => false
      t.integer :quality, :null => false
      t.float :price, :null => false
      
      t.timestamps
    end
  end
end

