class Itemstoorders < ActiveRecord::Migration
  def change
    # TODO
    drop_table :orders
    create_table :orders do |t|
      t.integer :employee_id
      t.belongs_to :items
    end
  end
end
