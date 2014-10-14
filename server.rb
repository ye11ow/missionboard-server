require 'sinatra'
require 'mongoid'
require './model/mission'

configure do
  mongo_config = "config/mongoid.yml"
  Mongoid.load!(mongo_config)
end

get '/missions/' do
  'missions'
end

post '/missions/' do
  m = Mission.create(
    title: "test",
    current: 123
  )
  "mission #{m.id} created"
end

get '/missions/:id' do
  "mission #{params[:id]}"
end

put '/missions/:id' do
  "mission #{params[:id]} updated"
end

delete '/missions/:id' do
  "mission #{params[:id]} deleted"
end