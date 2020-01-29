# frozen_string_literal: true

require 'sinatra/base'
require './lib/place'
require './lib/user'
require './lib/availabilities'

class Bnb < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    @user = session[:user]
    @places = Place.all
    erb :index
  end

  post '/users' do
    user = User.new_user(name: params[:name], email: params[:email], phone_number: params[:phonenumber], username: params[:username], password: params[:password])
    session[:user] = user
    redirect '/'
  end

  get '/places' do
    @places = Place.all
    erb :places
  end

  get '/users/new' do
    erb :'users/new'
  end

  delete '/session' do
    session.clear
    redirect '/'
  end

  get '/session/new' do
    erb :'session/new'
  end

  post '/session' do
    session[:user] = User.authenticate(username: params[:username], password: params[:password])
    redirect '/'
  end

  get '/places/new' do
    erb :'places/new'
  end

  post '/places' do
    place = Place.create(userid: session[:user].id, listingtitle: params[:listingtitle], description: params[:description], address: params[:address], ppn: params[:ppn])
    Avail.create(placesid: place.id, dates: "#{params[:from]},#{params[:to]})")
    redirect("/places/#{place.id}")
  end

  get '/places/:id' do 
    @place = Place.where(id: params[:id]).first
    @avail = Avail.where(placesid: params[:id]).first
    erb :'places/id'
  end 

  run! if app_file == $PROGRAM_NAME
end
