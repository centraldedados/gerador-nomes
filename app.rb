require 'sinatra'
require 'sinatra/reloader'
require "sinatra/multi_route"
require 'sinatra/cross_origin'
require "csv"
require "json"

require_relative 'helpers/methods'
require_relative 'helpers/settings'

# Load nomes e apelidos from CSV files as constants
NOMES, APELIDOS = load_data()
NOMES.freeze
APELIDOS.freeze
NOMES_COUNT = NOMES.count
APELIDOS_COUNT = APELIDOS.count

# Homepage
get '/' do
  content_type :html
  @nomes_count = NOMES_COUNT
  @apelidos_count = APELIDOS_COUNT
  erb :index
end

# API
get '/nome/aleatorio/?' do
  nome = NOMES.sample
  apelidos_random = APELIDOS.sample(2)
  [nome, apelidos_random[0], apelidos_random[1]].to_json
end

get '/nome/?', '/nomes/?', '/nomes/:number/?' do
  number_of_records = check_params(params[:number], request.path_info)
  NOMES.sample(number_of_records).to_json
end

get '/apelido/?', '/apelidos/?', '/apelidos/:number/?' do
  number_of_records = check_params(params[:number], request.path_info)
  APELIDOS.sample(number_of_records).to_json
end

