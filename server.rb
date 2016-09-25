require 'sinatra'
require 'pry'
require 'sqlite3'


begin
    puts "here"
    db = SQLite3::Database.open "database.db"
    db.execute "CREATE TABLE IF NOT EXISTS List(title TEXT, url TEXT)"
rescue SQLite3::Exception => e
    puts "Exception occurred"
    puts e
ensure
    db.close if db
end




get '/' do
	erb :index
end


get '/list' do
	db = SQLite3::Database.open "database.db"
	@links = db.execute "SELECT * FROM List"
	
	erb :list
end

post '/upload_link' do
	url = params[:url]
	title = params[:title]

	db = SQLite3::Database.open "database.db"
	db.execute "INSERT INTO List (title, url) VALUES ('#{title}', '#{url}')"
			
	redirect '/list'	

end
