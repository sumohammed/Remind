# This code will ensure the connection and data manipulation, for todo app
require 'dbi'
require 'etc'
module Base
	class MyBase
	#database framework(DBI):dbd(SQLite3):path
	#CONSTANT
	user = Etc.getlogin
	URL ="DBI:SQLite3:/home/#{Etc.getlogin.to_s}/Desktop/App/rubyApp/db/todo.sqlite"
	# CLASS/STATICS
		def make_connection
			begin
				if dbh = DBI.connect(URL)
				   return dbh
				end
			rescue DBI::DatabaseError => e
				   puts  "#{e.err}"
				   puts  "#{e.errstr}"
				   return false
			end
		end
	end
end
