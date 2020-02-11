class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists
end

#TTY prompt to get argument, return user if found or create user if not found
#Need to add password functionality via run console
    def find_or_create_user(username, password = nil)
        userlist = User.all.collect {|x| x.name}
        if userlist.include?(username)
            uobject = User.all.select{|x| x.name == username}
                if uobject[0].password != password
                    p "Wrong password, re-run program! :("
                    #username = gets.chomp
                    #password = gets.chomp
                    #find_or_create_user(username, password)
                    return 0
                end
            @uid = uobject[0].id
            uname = uobject[0].name
            p "Welcome back, #{uname}!"
        else
            User.create(name: username, password: password)
            uname = User.last.name
            p "Welcome, #{uname}!"
        end
    end

#View Playlists
    def view_playlists
        userplaylists = Playlist.where(user_id: @uid)
        if userplaylists.empty?
            print "No playlists found."
        else plnames = userplaylists.collect {|x| x.name} 
            plnames.map.with_index(1) do |playlist, id|
            puts "#{id} - #{playlist}"
            end
        end
    end
    
#Generate Playlist - TTY prompt for name
    def generate_playlist(name)
        Playlist.create(name: name, user_id: @uid)
    end

#Generate Playlist by Genre - TTY prompt for genre - NEED TO GET ARTISTS IN NESTED ARRAY
    def generate_playlist_by_genre(name, genre)
        RSpotify.authenticate("a09377aa120c4a68ba377892982cb5cf", "c3a52e31188c43b6930c737fbe8a3026")
        generate_playlist(name)
        lastpl = Playlist.last
        lastpl.user_id = @uid
        10.times do
            rec = RSpotify::Recommendations.generate(limit: 1, seed_genres: [genre])
            rec_songs = rec.tracks
            rec_aa = rec_songs.collect{|x| x.album.artists}
            p rec_aa = rec_aa[0].collect{|x| x.name}
            a = Artist.create(name: rec_aa[0])
            p rec_song = rec.tracks.collect{|x| x.name}
            s = Song.create(title: rec_song[0])
            SongsArtists.create(song: s, artist: a)
            PlaylistsSongs.create(playlist: lastpl, song: s)
        end
        #rec_song.map.with_index(1) do |playlist, id|
        #    puts "#{id} - #{playlist}"
        #end
    end

#Remove Playlist
    def remove_playlist(name)
        if Playlist.where(name: name) == []
            p "No matching playlist."
        else
            Playlist.where(name: name).destroy_all
        end
    end




