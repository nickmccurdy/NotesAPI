require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'

# Configuration

set :database, { adapter: 'sqlite3', database: 'db/development.sqlite3' }
set :port, 3000

# Models

class Note < ActiveRecord::Base
end

# Routes

error do
  json env['sinatra.error'].name
end

get '/' do
  json Note.all
end

post '/' do
  json Note.create(
    name: params['name'],  
    body: params['body']
  )
end

get '/:id' do
  json Note.find params['id'].to_i
end

put '/:id' do
  note = Note.find params['id'].to_i
  note.name = params['name']
  note.body = params['body']
  json note
end

delete '/:id' do
  note = Note.find params['id'].to_i
  json note.delete
end
