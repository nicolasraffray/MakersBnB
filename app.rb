require 'sinatra/base'
require './lib/place'
class Bnb < Sinatra::Base

  get '/' do 
   erb :index

  end 

 get '/places' do 
   @places = Place.all
   erb :places


  end 



 run! if app_file == $0

end 