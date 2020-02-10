require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

require_relative "../app/models/artist.rb"
require_relative "../app/models/genre.rb"
require_relative "../app/models/playlist_song.rb"
require_relative "../app/models/playlist.rb"
require_relative "../app/models/song_artist.rb"
require_relative "../app/models/song_genre.rb"
require_relative "../app/models/song.rb"
require_relative "../app/models/user.rb"