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



# Homepage
get '/' do
  content_type :html
  @nomes_count = nomes.count
  @apelidos_count = apelidos.count
  @nome1 = nomes.sample
  @apelido1 = apelidos.sample
  @apelido2 = apelidos.sample
  erb :index
end


# API
get '/nome/aleatorio' do
  @nome1 = nomes.sample
  @apelido1 = apelidos.sample
  @apelido2 = apelidos.sample
  [@nome1, @apelido1, @apelido2].to_json
end

get '/nome' do
  nomes.sample.to_json
end

get '/nomes', '/nomes/:number' do
  params['number'] ? number = params['number'].to_i : number = 10
  nomes.shuffle[0,number].to_json
end


get '/apelido' do
  apelidos.sample.to_json
end

get '/apelidos', '/apelidos/:number' do
  params['number'] ? number = params['number'].to_i : number = 10
  apelidos.shuffle[0,number].to_json
end


