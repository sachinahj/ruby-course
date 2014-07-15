class Overhaul2 < ActiveRecord::Migration
  def change
    # TODO
    drop_table :orders_items
    create_table :orders_items do |t|
      t.belongs_to :order
      t.belongs_to :item
    end
  end
end
