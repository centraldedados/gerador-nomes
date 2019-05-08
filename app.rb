# encoding: utf-8

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'sinatra'
require 'sinatra/reloader'
require "sinatra/multi_route"
require 'sinatra/cross_origin'
require "csv"
require "json"

# Enabel cross origin for all routes
configure do
  enable :cross_origin
end

set :protection, :except => [:frame_options, :json_csrf]

# Set content type to JSON
# override this for homepage
before do
  content_type 'application/json'
end


# Nomes e Apelidos
nomes = Array.new
apelidos = Array.new

File.read("data/nomes.csv").each_line do |line|
  nomes << line.strip
end

File.read("data/apelidos.csv").each_line do |line|
  apelidos << line.strip
end


# API helper method to parse the number of records to return
def check_params(params_number, request_path_info)
  # check if the route is plural or not
  if !request.path_info.include? "s"
    return 1
  else
    if params_number
      number = params_number.to_i <= 100 ? params_number.to_i : 100
    else
      number = 10
    end
    return number
  end
end



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


