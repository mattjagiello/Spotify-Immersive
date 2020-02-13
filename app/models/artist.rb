require 'rubygems'
require 'wikipedia'
require 'active_record'
require 'pry'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

class Artist < ActiveRecord::Base
    has_and_belongs_to_many :songs
    
    def view_artist_tour_info
        params = {keyword: "#{self.name}", page: 0, size: 10, source: 'ticketmaster'}
        client = Ticketmaster.client(apikey: '2WjVyw4Z3BhfAwkyncjaWMATZy2MwaV0')
        response = client.search_events(params: params)
        event = response.results.first

        if event == nil
            puts "Could not find touring data for #{self.name}"
        else
            name = event.name
            date = event.dates["start"]["localDate"]
            location = event.venues[0].data["name"]
            time = event.dates["start"]["localTime"]
            timezone = event.dates["timezone"]
            city = event.venues[0].data["city"]["name"]
            if event.venues[0].data.include?("state")
                state = event.venues[0].data["state"]["name"]
                puts "#{name} is playing at #{location} in #{city}, #{state} on #{date} at #{time},#{timezone}"
            else
                puts "#{name} is playing at #{location} in #{city} on #{date} at #{time},#{timezone}"
            end
        end
        # command = nil
        # while (command != "leave")
        #     puts "type 'leave' to exit"
        #     if command == "leave"
        #         return
        #     end
        # end

    end

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
end