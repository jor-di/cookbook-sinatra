require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'modele/cookbook'
require_relative 'modele/recipe'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do
  @cookbook = Cookbook.new('modele/recipes.csv')
  erb :index
end

# [...]

get '/about' do
  erb :about
end

# [...]

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

# [...]

get '/new' do
  erb :new
end

post '/recipes' do
  recipe_to_add = Recipe.new(params[:name], params[:description])
  @cookbook = Cookbook.new('modele/recipes.csv')
  @cookbook.add_recipe(recipe_to_add)
  redirect '/'
end

get '/destroy' do
  @cookbook = Cookbook.new('modele/recipes.csv')
  erb :destroy
end

post '/destroy' do
  @cookbook = Cookbook.new('modele/recipes.csv')
  @cookbook.remove_recipe(params[:index_to_destroy].to_i - 1)
  redirect '/'
end
