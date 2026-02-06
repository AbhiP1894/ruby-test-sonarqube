require 'sqlite3'

get '/user' do
  db = SQLite3::Database.new "development.db"

  # ❌ VULNERABLE: string interpolation
  username = params[:name]
  query = "SELECT * FROM users WHERE name = '#{username}'"

  db.execute(query).to_s
end
