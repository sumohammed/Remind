# This code will ensure the connection and data manipulation, for the app
require 'dbi'
require 'etc'
require 'sqlite3'

module Base
  class MyBase
    URL ="DBI:SQLite3:/home/#{Etc.getlogin.to_s}/.remind/.db/remind.sqlite"
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
