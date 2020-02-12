require 'bundler'
Bundler.require
require 'active_record'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
RSpotify.authenticate("a09377aa120c4a68ba377892982cb5cf", "c3a52e31188c43b6930c737fbe8a3026")

require_all 'app/models'