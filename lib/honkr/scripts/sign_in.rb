module Honkr
  class SignIn

    def self.run(params)
      # TODO
      # p "params --> #{params}"
      user = Honkr.db.get_user_by_username(params[:username])
      # p "user --> #{user}"
      if  user == nil
        return {
          :success? => false,
          :error => :no_user_exist,
          :session_id => "no id"
        }
      elsif user.has_password?(params[:password]) == false 
        return {
          :success? => false,
          :error => :invalid_password,
          :session_id => "no id"
        }
      elsif user.has_password?(params[:password]) == true
        return {
          :success? => true,
          :error => :none,
          :session_id => Honkr.db.create_session(:user_id => user.id)
        }
      else
        return {
          :success? => false,
          :error => :no_idea,
          :session_id => "no id"
        }
      end
    end
  end
end
