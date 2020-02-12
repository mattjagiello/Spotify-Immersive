require_relative '../config/environment'

User.find_or_create_user("User")

puts "HELLO WORLD"
