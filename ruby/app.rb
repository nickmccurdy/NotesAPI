require 'sinatra'
require 'sinatra/activerecord'

# Configuration

set :database, { adapter: 'sqlite3', database: 'db/development.sqlite3' }
set :port, 3000

# Models

class Note < ActiveRecord::Base
end

# Routes

before do
  content_type 'application/json'
end

error do
  env['sinatra.error'].name
end

get '/' do
  Note.all.to_json
end

post '/' do
  note = Note.create
  note.name = params[:name]
  note.body = params[:body]
  note.save
  headers['Location'] = "/#{note._id}"
  status 201
end

get '/:id' do
  Note.find(params[:id]).to_json
end

put '/:id' do
  note = Note.find params[:id]
  note.name = params[:name]
  note.body = params[:body]
  headers['Location'] = "/#{note._id}"
  status 201
end

delete '/:id' do
  Note.find(params[:id]).delete
  status 204
end
