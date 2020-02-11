class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists
end

#TTY prompt to get argument, return user if found or create user if not found
    # def find_or_create_user(username)
    #     userlist = User.all.collect {|x| x.name}
    #       if user.include?(username)
    #         uname = User.all.find{|x| x.name == username}
    #       else
    #         User.create(name: username)
    #         uname = User.last.name
    #     end
    # end

#View Playlists
    def view_playlists(userid)
        selectedplaylist = Playlist.all.select{|x| x.user_id == userid}
        if selectedplaylist.empty?
            print "No playlists found."
        else selectedplaylist.map.with_index do |playlist, id|
            puts "#{id} - #{playlist}"
            end
        end
    end
    

#Login to user

#Store user information as variables
    #current_user = user.id



