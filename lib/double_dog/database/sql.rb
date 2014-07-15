require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'double-dog_test'
)

module DoubleDog
  module Database
    class SQL

      class User < ActiveRecord::Base
      end
      class Session < ActiveRecord::Base
      end
      class Item < ActiveRecord::Base
        has_many :orders, :through => :orders_items
      end
      class Order < ActiveRecord::Base
        has_many :items, :through => :orders_items
      end
      class Orders_Items < ActiveRecord::Base
        belongs_to :item
        belongs_to :order
      end

      def clear_everything
        User.delete_all
        Session.delete_all
        Item.delete_all
        Order.delete_all
        Orders_Items.delete_all
      end

      def create_user(attrs)
        ar_user = User.create(attrs)
        DoubleDog::User.new(ar_user[:id], ar_user[:username], ar_user[:password], ar_user[:admin])
      end

      def get_user(id)
        ar_user = User.find(id)
        DoubleDog::User.new(ar_user[:id], ar_user[:username], ar_user[:password], ar_user[:admin])
      end

      def create_session(attrs)
        ar_session = Session.create(attrs)
        return ar_session.id
      end

      def get_user_by_session_id(sid)
        ar_session = Session.find(sid)
        return nil if ar_session.nil?
        ar_user = User.find(ar_session.user_id)
        DoubleDog::User.new(ar_user[:id], ar_user[:username], ar_user[:password], ar_user[:admin])
      end

      def get_user_by_username(username)
        ar_user = User.find_by(username: username)
        return nil if ar_user.nil?
        DoubleDog::User.new(ar_user[:id], ar_user[:username], ar_user[:password], ar_user[:admin])
      end

      def create_item(attrs)
        ar_item = Item.create(attrs)
        DoubleDog::Item.new(ar_item[:id], ar_item[:name], ar_item[:price])
      end

      def get_item(id)
        ar_item = Item.find(id)
        DoubleDog::Item.new(ar_item[:id], ar_item[:name], ar_item[:price])
      end

      def all_items
        ar_items = Item.all
        items = ar_items.map do |attrs|
          DoubleDog::Item.new(attrs[:id], attrs[:name], attrs[:price])
        end
        return items
      end

      def create_order(attrs)
        ar_order = Order.create(employee_id: attrs[:employee_id])
        attrs[:items].each do |x|
          Orders_Items.create(order_id: ar_order.id, item_id: x.id)
        end
        DoubleDog::Order.new(ar_order[:id], ar_order[:employee_id], ar_order[:items])
      end

      def get_order(id)
        ar_order = Order.find(id)
        items = Orders_Items.where(order_id: ar_order.id).pluck(:item_id)
        items.map! do |id|
          get_item(id)
        end
        DoubleDog::Order.new(ar_order[:id], ar_order[:employee_id], items)
      end

      def all_orders
        ar_orders = Order.all
        orders = [];
        ar_orders.each do |x|
          orders << get_order(x.id)
        end
        orders
      end


    end
  end
end
