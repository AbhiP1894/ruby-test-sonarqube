require 'sinatra'
require 'sqlite3'
require 'erb'

require 'sinatra'
require 'sqlite3'
require 'erb'

# SQL Injection vulnerability
# def run_query(query)
#   db = SQLite3::Database.new 'development.db'
#   db.execute(query) # Unsafe, allows SQL Injection
# end
def run_query(query)
  db = SQLite3::Database.new 'development.db'
  db.execute(query)
  # db.close is missing → resource leak
end

# Potentially vulnerable to SQL Injection
post '/search' do
  name = params[:name]
  query = "SELECT * FROM users WHERE name = '#{name}'" # Unsanitized input
  @results = run_query(query)
  erb :index
end

# Duplication of search logic in multiple routes
post '/find_user' do
  name = params[:name]
  query = "SELECT * FROM users WHERE name = '#{name}'" # Duplicated logic
  @results = run_query(query)
  erb :index
end

# Another route duplicating the logic
post '/lookup_user' do
  name = params[:name]
  query = "SELECT * FROM users WHERE name = '#{name}'" # More duplicated logic
  @results = run_query(query)
  erb :index
end

# Yet another route duplicating the search logic
post '/get_user' do
  name = params[:name]
  query = "SELECT * FROM users WHERE name = '#{name}'" # Continued duplication
  @results = run_query(query)
  erb :index
end

get '/' do
  @message = params[:message]
  erb :index # Potential XSS vulnerability
end








# require 'sinatra'
# require 'sqlite3'
# require 'erb'

# # SQL Injection vulnerability
# def run_query(query)
#   db = SQLite3::Database.new 'development.db'
#   db.execute(query) # Unsafe, allows SQL Injection
# end

# get '/' do
#   @message = params[:message]
#   erb :index # Potential XSS vulnerability
# end

# # Potentially vulnerable to SQL Injection
# post '/search' do
#   name = params[:name]
#   query = "SELECT * FROM users WHERE name = '#{name}'" # Unsanitized input
#   @results = run_query(query)
#   erb :index
# end
