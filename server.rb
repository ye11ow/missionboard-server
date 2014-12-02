require 'sinatra'
require 'mongoid'
require 'json'
require './model/mission'
require './model/category'

configure do
  set :public_folder, File.dirname(__FILE__) + '/../missionboard-client'
  mongo_config = "config/mongoid.yml"
  Mongoid.load!(mongo_config)
end

get '/missions/' do
  content_type 'application/json'

  Mission.all.entries.to_json
end

post '/missions/' do
  content_type 'application/json'

  mission = Mission.create(
    title: params[:title],
    current: Integer(params[:current]),
    total: Integer(params[:total]),
    category: params[:category],
    description: params[:description],
    completed: params[:completed],
    createdAt: Time.at(Integer(params[:createdAt]) / 1000)
  )
  mission.to_json
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

put '/missions/:id/progress' do
  current = Integer(params[:current])
  completed = params[:completed]
  
  mission = Mission.find(params[:id])

  mission.set(
    current: Integer(params[:current]),
    completed: completed
  )

  "mission #{params[:id]} progress"
end

delete '/missions/:id' do
  mission = Mission.new(id: params[:id])
  mission.delete
  "mission #{params[:id]} deleted"
end

get '/categories/' do
  content_type 'application/json'

  Category.all.entries.to_json
end

put '/categories/:id' do  
  Category.find(params[:id]).set(
    title: params[:title],
    order: Integer(params[:order])
  )

  Category.find(params[:id]).orderby.set(
    by: params[:orderby][:by],
    type: params[:orderby][:type]
  )
  "category #{params[:id]} updated"
end

post '/categories/' do
  content_type 'application/json'

  category = Category.create(
    id: params[:id],
    title: params[:title],
    system: false,
    order: params[:order],
  )

  category.create_orderby(
    by: "title",
    type: "asc"
  )

  category.to_json
end

delete '/categories/:id' do
  category = Category.new(id: params[:id])
  category.delete
  "category #{params[:id]} deleted"
end