require 'rubygems'
require 'wikipedia'
require 'pry'
require 'tty-prompt'
class WikipediaTest
    Wikipedia.configure {
        domain 'en.wikipedia.org'
        path   'w/api.php'
      }
    page = Wikipedia.find( 'black keys' )
    big_data = []
    big_data << page.text.split(".")
    prompt = TTY::Prompt.new
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