# encoding: utf-8

require 'sinatra'
require 'sinatra/reloader'
require "sinatra/multi_route"
require "csv"

# Nomes e Apelidos
nomes = Array.new
apelidos = Array.new

File.read("data/nomes.csv").each_line do |line|
  nomes << line
end

File.read("data/apelidos.csv").each_line do |line|
  apelidos << line
end


# Homepage
get '/' do
  @nomes_count = nomes.count
  @apelidos_count = apelidos.count
  @nome1 = nomes.sample
  @apelido1 = apelidos.sample
  @apelido2 = apelidos.sample
  erb :index
end


# API
get '/nome_aleatorio' do
  @nome1 = nomes.sample
  @apelido1 = apelidos.sample
  @apelido2 = apelidos.sample
  [@nome1, @apelido1, @apelido2].to_json
end

get '/nome' do
  nomes.sample
end

get '/apelido' do
  apelidos.sample
end

get '/nomes', '/nomes/:number' do
  if params['number']
    number = params['number'].to_i
  else
    number = 10
  end
  nomes.shuffle[0,number].to_json
end

get '/apelidos', '/apelidos/:number' do
  if params['number']
    number = params['number'].to_i
  else
    number = 10
  end
  apelidos.shuffle[0,number].to_json
end


