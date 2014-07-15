class Createorders < ActiveRecord::Migration
  def change
    # TODO
    create_table :orders do |t|
      t.integer :employee_id
    end
  end
end
