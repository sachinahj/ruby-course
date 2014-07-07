require 'unirest'
require 'pry-byebug'

module GHFeed

  class RepoInfo
    def self.get_repo_data(username, repo)
      myusername = ENV['USERNAME']
      mypassword = ENV['PASSWORD']
      # nick = ENV['NICKISCOOL']
      # binding.pry
      uri = "https://api.github.com/repos/#{username}/#{repo}/commits"

      response = Unirest.get(uri, 
        headers: { "Accept" => "application/vnd.github.v3+json" }, 
        parameters: Array,
        auth: { :user => myusername, :password => mypassword }
      )

      return response.body
      
    end
    
  end

  class UserInfo
  end

end