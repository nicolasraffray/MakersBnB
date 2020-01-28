require 'sinatra/base'
require 'place'
class Bnb < Sinatra::Base

  get '/' do 
   erb :index

  end 

 get '/all' do 
   @all = Place.all
   erb :all


  end 



 run! if app_file == $0

end 