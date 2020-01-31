# frozen_string_literal: true
require 'sequel'
require 'sinatra/base'
require 'sinatra/flash'
require './lib/place'
require './lib/user'
require './lib/availabilities'
require './lib/bookings'

class Bnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  before do
    @user = session[:user]
  end

  get '/' do
    redirect 'places'
  end

  post '/users' do
    if User.where(username: params[:username]).any?
      flash[:notice] = 'Username already in use'
      redirect '/users/new'
    elsif User.where(email: params[:email]).any?
      flash[:notice] = 'Email already in use'
      redirect '/users/new'
    elsif User.where(phonenumber: params[:phonenumber]).any?
      flash[:notice] = 'Phone number already in use'
      redirect '/users/new'
    else
      user = User.new_user(name: params[:name], email: params[:email], phone_number: params[:phonenumber], username: params[:username], password: params[:password])
      session[:user] = user
      redirect '/'
    end
  end

  get '/places' do
    @places = Place.all
    erb :'places/index'
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
    user = User.authenticate(username: params[:username], password: params[:password])
    if user
      session[:user] = user
      redirect '/'
    else
      flash[:notice] = 'Please check your email or password'
      redirect '/session/new'
    end
  end

  get '/places/new' do
    erb :'places/new'
  end

  post '/places' do
    place = Place.create(userid: session[:user].id, listingtitle: params[:listingtitle], description: params[:description], address: params[:address], ppn: params[:ppn])
    Avail.new_avail(place_id: place.id, dates: params[:dates])
    redirect("/places/#{place.id}")
  end

  get '/places/:id' do
    @place = Place.where(id: params[:id]).first
    @avail = Avail.where(placesid: params[:id]).first
    erb :'places/id'
  end

  get '/places/:id/bookings/new' do
    @place = Place.where(id: params[:id]).first
    erb :'bookings/new'
  end

  post '/places/:id/bookings' do
    booking = Booking.new_booking(place_id: params[:id], user_id: session[:user].id, dates: params[:dates])
    if booking == "There is no Availability"
      flash[:notice] = 'Please Book Within The Available Dates'
      redirect '/places/:id/bookings/new'
    else
      redirect "/users/#{session[:user].id}/mybookings"
    end 
  end

  get "/users/:id/mybookings" do 
    @bookings = Booking.where(userid: session[:user].id).map([:placesid, :bookingfrom, :bookingto, :confirm])
    @place = Place
    erb :'bookings/mybookings'
  end 

  get "/users/:id/mylistings" do 
    @places = Place.where(userid: session[:user].id).map(:id)
    @booking = Booking 
    
    erb :'bookings/mylistings'
  end 

  post "/users/:id/mylistings" do 
    p params
    place = Booking.where(id: params[:bookingid])
    place.update({confirm: true})
    redirect("/users/:id/mylistings")
  end 
  

  run! if app_file == $PROGRAM_NAME
end
