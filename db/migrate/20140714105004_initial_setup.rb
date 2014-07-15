class InitialSetup < ActiveRecord::Migration
  def change
    # TODO
    create_table :users do |t|
      t.string :username
      t.string :password
      t.boolean :admin
    end

    create_table :items do |t|
      t.belongs_to :order
      t.string :name
      t.integer :price
    end

    create_table :orders do |t|
      t.belongs_to :user
    end

    create_table :sessions do |t|
      t.belongs_to :user
    end

  end
end
