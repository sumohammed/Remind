# This code will ensure the connection and data manipulation, for todo app
require 'dbi'
require 'etc'

module Base
	class MyBase
		URL ="DBI:SQLite3:/home/#{Etc.getlogin.to_s}/.todo/.db/todo.sqlite"
		def make_connection
			begin
				if dbh = DBI.connect(URL)
				   return dbh
				end
			rescue DBI::DatabaseError => e
				   puts  "#{e.err}"
				   puts  "#{e.errstr}"
				   return
			end
		end
	end
end
