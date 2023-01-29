
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/multi_route"
require 'sinatra/cross_origin'
require "csv"
require "json"

require_relative 'helpers/methods'
require_relative 'helpers/settings'

# Load nomes e apelidos from CSV files
nomes, apelidos = load_data()


# Homepage
get '/' do
  content_type :html
  @nomes_count = nomes.count
  @apelidos_count = apelidos.count
  erb :index
end


# API
get '/nome/aleatorio/?' do
  nome = nomes.sample
  apelidos_random = apelidos.shuffle[0,2]
  [nome, apelidos_random[0], apelidos_random[1]].to_json
end

get '/nome/?', '/nomes/?', '/nomes/:number/?' do
  number_of_records = check_params(params[:number], request.path_info)
  nomes.shuffle[0,number_of_records].to_json
end

get '/apelido/?', '/apelidos/?', '/apelidos/:number/?' do
  number_of_records = check_params(params[:number], request.path_info)
  apelidos.shuffle[0,number_of_records].to_json
end

