require "bundler/setup"
require "sinatra"

get '/' do
  db = Mysql2::Client.new(:host => "DB_SERVER", :username => "DB_USERNAME", :password => "DB_PASSWORD", :database => "DB_DATABASE")
  @results = db.query("SELECT * FROM Popularity ORDER BY Changes DESC")
  erb :index
end