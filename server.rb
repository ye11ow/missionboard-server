require 'sinatra'
require 'mongoid'
require 'json'
require './model/mission'

configure do
  set :public_folder, File.dirname(__FILE__) + '/../missionboard-client'
  p File.dirname(__FILE__) + '../missionboard-client'
  mongo_config = "config/mongoid.yml"
  Mongoid.load!(mongo_config)
end

get '/missions/' do
  Mission.all.entries.to_json
end

post '/missions/' do
  m = Mission.create(
    title: params[:title],
    current: params[:current],
    total: params[:total],
    category: params[:category],
    description: params[:description],
    completed: params[:completed],
    createdAt: params[:createdAt])
  )
  "mission #{m.id} created"
end

#get '/missions/:id' do
  #p Mission.where(title: "hello")
  #p mission.find
#  "mission #{params[:id]}"
#end

put '/missions/:id' do
  "mission #{params[:id]} updated"
end

delete '/missions/:id' do
  mission = Mission.new(id: params[:id])
  mission.delete
  "mission #{params[:id]} deleted"
end