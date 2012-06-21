$: << './lib'

require 'sinatra'
require 'erb'
require './lib/image.rb'
require './lib/facecheck.rb'
require './lib/twitter.rb'

get '/' do
  erb :index
end

get '/user/:user' do

  @user = params[:user]
  if !File.exists?("/tmp/#{@user}.png")
    Twitter.get_icon(@user)
    FaceCheck.mapping(@user)
  end

  erb :index
end

get '/generate' do
  redirect "/user/#{params[:twitter_id]}"
end

get '/images/icon/:file' do
  content_type 'image/jpeg'
  File.open("/tmp/#{params[:file]}", 'rb') { |f| f.read }
end
