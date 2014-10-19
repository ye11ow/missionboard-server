require 'sinatra'
require 'mongoid'
require 'json'
require './model/mission'
require './model/category'

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
    current: Integer(params[:current]),
    total: Integer(params[:total]),
    category: params[:category],
    description: params[:description],
    completed: params[:completed],
    createdAt: Time.at(Integer(params[:createdAt]) / 1000)
  )
  "mission #{m.id} created"
end

#get '/missions/:id' do
  #p Mission.where(title: "hello")
  #p mission.find
#  "mission #{params[:id]}"
#end

put '/missions/:id' do
  Mission.find(params[:id]).set(
    title: params[:title],
    current: Integer(params[:current]),
    total: Integer(params[:total]),
    category: params[:category],
    description: params[:description],
    completed: params[:completed],
  )
  "mission #{params[:id]} updated"
end

put '/missions/:id/doit' do
  Mission.find(params[:id]).set(current: Integer(params[:current]))
  "mission #{params[:id]} doit"
end

delete '/missions/:id' do
  mission = Mission.new(id: params[:id])
  mission.delete
  "mission #{params[:id]} deleted"
end

get '/categories/' do
  Category.all.entries.to_json
end

put '/categories/:id' do
  Category.find(params[:id]).set(
    title: params[:title],
    filter: params[:filter]
  )
  "category #{params[:id]} updated"
end

post '/categories/' do
  m = Category.create(
    title: params[:title],
    filter: "all"
  )
  "category #{m.id} created"
end

delete '/categories/:id' do
  category = Category.new(id: params[:id])
  category.delete
  "category #{params[:id]} deleted"
end