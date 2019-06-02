class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :purchase_opt
      t.references :user
      t.timestamps
    end
  end
end
