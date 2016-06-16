# This code will ensure the connection and data manipulation, for the app
require 'dbi'
require 'etc'
require 'sqlite3'

module Base
  class MyBase
    URL = "DBI:SQLite3:/home/#{Etc.getlogin}/.remind/.db/remind.sqlite".freeze
    def make_connection
      if dbh = DBI.connect(URL)
        return dbh
      end
    rescue DBI::DatabaseError => e
      puts e.err.to_s
      puts e.errstr.to_s
      return
    end
  end
end
