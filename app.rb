# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require './lib/place'
require './lib/user'

class Bnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    @user = session[:user]
    @places = Place.all
    erb :index
  end

  post '/users' do
    if User.where(:username => params[:username]).any?
      flash[:notice] = 'Username already in use'
      redirect '/users/new'
    elsif User.where(:email => params[:email]).any?
      flash[:notice] = 'Email already in use'
      redirect '/users/new'
    elsif User.where(:phonenumber => params[:phonenumber]).any?
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
    Place.create(userid: session[:user].id, listingtitle: params[:listingtitle], description: params[:description], address: params[:address], ppn: params[:ppn])
    redirect('/')
  end

  run! if app_file == $PROGRAM_NAME
end
