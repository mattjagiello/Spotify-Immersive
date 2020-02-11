class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists
end

#TTY prompt to get argument, return user if found or create user if not found
#Need to add password functionality
    def find_or_create_user(username)
        userlist = User.all.collect {|x| x.name}
        if userlist.include?(username)
            uname = userlist.select{|x| x == username}
            p "Welcome back, #{uname[0]}!"
        else
            User.create(name: username)
            uname = User.last.name
            p "Welcome, #{uname}!"
        end
    end

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

#Generate Playlist by Genre - TTY prompt for genre - NEED TO GET ARTISTS IN NESTED ARRAY
    # def generate_playlist_by_genre(genre)
    #     RSpotify.authenticate("a09377aa120c4a68ba377892982cb5cf", "c3a52e31188c43b6930c737fbe8a3026")
    #     recommendations = RSpotify::Recommendations.generate(limit: 1, seed_genres: ["blues"])
    #     rec_songs = recommendations.tracks.collect {|x| x.name}
    #     rec_songs.map.with_index(1) do |playlist, id|
    #         puts "#{id} - #{playlist}"
    #     end
    # end

#Remove Playlist
    def remove_playlist(name)
        if Playlist.where(name: name) == []
            p "No matching playlist."
        else
            Playlist.where(name: name).destroy_all
        end
    end




