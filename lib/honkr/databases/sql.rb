require 'active_record'

module Honkr
  module Databases
    class SQL

      class User < ActiveRecord::Base
      end
      class Honk < ActiveRecord::Base
      end

      def persist_honk(honk)
        attrs = {
          :user_id => honk.user_id,
          :content => honk.content
        }
        # Save the new honk data in the database (in this case, a hash)
        ar_honk = Honk.create(attrs)
        # Add the new id to the honk object
        honk.instance_variable_set("@id", ar_honk.id)
      end

      def get_honk(id)
        ar_honk = Honk.find(id)
        Honkr::Honk.new(ar_honk[:id], ar_honk[:user_id], ar_honk[:content])
      end

      def persist_user(user)
        attrs = {
          :name => user.username,
          :password_digest => user.password_digest
        }
        # Save the new user data in the database (in this case, a hash)
        ar_user = User.create(attrs)
        # Add the new id to the user object
        user.instance_variable_set("@id", ar_user.id)
      end

      def get_user(id)
        ar_user = User.find(id)
        Honkr::User.new(ar_user[:id], ar_user[:name], ar_user[:password_digest])
      end

    end
  end
end
