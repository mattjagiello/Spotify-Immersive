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

#Store user information as variables
    #uid = user.id

#View Playlists
    def view_playlists(userid)
        selectedplaylist = Playlist.where(user_id: userid)
        if selectedplaylist.empty?
            print "No playlists found."
        else selectedplaylist.map.with_index(1) do |playlist, id|
            puts "#{id} - #{playlist}"
            end
        end
    end
    
#Generate Playlist - TTY prompt for name - how to get User ID?
    def generate_playlist(name)
        Playlist.create(name: name)
        #Playlist.last.user_id = 
    end

#Generate Playlist by Genre - TTY prompt for genre
    def generate_playlist_by_genre
    end





