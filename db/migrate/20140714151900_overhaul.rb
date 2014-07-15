class Overhaul < ActiveRecord::Migration
  def change
    # TODO
    remove_column :orders, :items_id
    create_table :orders_items, id: false do |t|
      t.integer :order_id
      t.integer :item_id
    end
  end
end
