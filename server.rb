require 'sinatra'

set :bind, '0.0.0.0'

get '/' do 
  "Hey!!! This is a web app."
end

