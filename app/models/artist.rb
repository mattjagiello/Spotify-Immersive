require 'rubygems'
require 'wikipedia'
require 'active_record'
require 'pry'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

class Artist < ActiveRecord::Base
    has_and_belongs_to_many :songs


def read_info
    Wikipedia.configure {
domain 'en.wikipedia.org'
path   'w/api.php'
}
artist_name = self.name
page = Wikipedia.find( "#{artist_name}" )
big_data = []
big_data << page.text.split(".")
command = "\n"
index = 0
puts "press enter"
while (command != "leave")
    command = gets
    case command
    when "\n"
        puts big_data[0][index]
        index += 1
    when "leave\n"
        break
    end
end
end
binding.pry
end