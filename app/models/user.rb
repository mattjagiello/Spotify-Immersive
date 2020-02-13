class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists

#Prompt for user login/password, calls self.find_or_create_user method
def self.login
    prompt = TTY::Prompt.new
    name = prompt.ask ("Enter username to login or create new user. Type 'Exit' to quit.") do |q|
        q.required true
        q.validate /\A\w+\Z/
        end
        if name == "Exit"
            exit
        end
    password = prompt.mask("Enter a password - not required.")
    User.find_or_create_user(name, password)
    puts "#{name}'s Playlist Options"
    login_user = User.all.select{|x| x.name == name}
    login_user[0].playlist_options
    end

#TTY prompt to get argument, return user if found or create user if not found
    def self.find_or_create_user(username, password = nil)
        userlist = User.all.collect {|x| x.name}
        if userlist.include?(username)
            uobject = User.all.select{|x| x.name == username}
                if uobject[0].password != password
                    p "Wrong password, try again!"
                    User.login
                end
            id = uobject[0].id
            uname = uobject[0].name
            p "Welcome back, #{uname}!"
        else
            User.create(name: username, password: password)
            uname = User.last.name
            p "Welcome, #{uname}!"
        end
    end

#View Playlist Options
    def playlist_options
        prompt = TTY::Prompt.new
        selection = prompt.select("Choose an option.") do |menu|
            menu.choice name: 'View My Playlists', value: 1
            menu.choice name: 'Add New Playlist', value: 2
            menu.choice name: 'Delete A Playlist', value: 3
            menu.choice name: 'Logout', value: 4
        end

        case selection
        when 1
            self.view_playlists_as_table
        when 2
            self.playlist_pick
        when 3
            self.view_playlists_as_table
            name = prompt.ask ("Enter a playlist name to delete.") do |q|
                q.required true
                if name == "Back"
                    self.playlist_options
                end
            end
            all_plnames = Playlist.all.collect{|x| x.name}
            if all_plnames.exclude?(name)
                puts "No matching playlist name -- try again." 
            else
                self.remove_playlist(name)
                puts "Playlist #{name} deleted!"
            end
            self.playlist_options
        when 4
            puts "Bye!"
            User.login
        end
    end

#View Playlists
    def view_playlists
        table_data = []
        userplaylists = Playlist.where(user_id: self.id)
        if userplaylists.empty?
            print "No playlists found. "
            self.playlist_options
        else plnames = userplaylists.collect {|x| x.name} 
            plnames.map.with_index(1) do |playlist, id|
                table_data << {name: "#{playlist}", no: "#{id}"}
            end
        end
        table_data
    end  

    def choose_playlist(selection_number)
        playlist = []
        Playlist.all.each do |p|
            if p.user == self
                playlist << p
            end
        end
        #\/ \/ \/ \/ \/ \/#not sure if this is very robust\/ \/ \/ \/ \/
        #binding.pry
        playlist[selection_number-1].display_playlist_as_table
        playlist[selection_number-1].display_options
    end

    def view_playlists_as_table
        Formatador.display_table(self.view_playlists)
        prompt = TTY::Prompt.new
        input = prompt.ask('Enter playlist number or "0" to go back.')
        if name == "0"
            self.playlist_options
        else
        self.playlist_options
        end
    end

    #Generate Blank Playlist or By Genre
def playlist_pick
    prompt = TTY::Prompt.new
    selection = prompt.select("Choose an option.") do |menu|
        menu.choice name: 'Generate blank playlist.', value: 1
        menu.choice name: 'Generate Spotify recommended playlist by genre.', value: 2
        menu.choice name: 'Back', value: 3
    end
    
    case selection
    when 1
        plname = prompt.ask ("Enter a playlist name.") do |q|
            q.required true
        end
        self.generate_playlist(plname)
        p "Playlist #{plname} created!"
        self.playlist_options
    when 2
        name = prompt.ask ("Enter a playlist name.") do |q|
            q.required true
        end
        genre = prompt.ask ("Enter a genre.") do |q|
            q.required true
        end
        plnumber = prompt.ask ("Enter number of songs to add to playlist (up to 10).") do |q|
            q.required true
        end
        number = plnumber.to_i
        self.generate_playlist_by_genre(name, genre, number)
        puts "#{name} playlist created!"
        self.playlist_options
    when 3
        self.playlist_options
    end
end

#Generate Playlist - TTY prompt for name
    def generate_playlist(name)
        Playlist.create(name: name, user_id: self.id)
    end

#Generate Playlist by Genre - TTY prompt for name, genre, number
    def generate_playlist_by_genre(name, genre, number)
        RSpotify.authenticate("a09377aa120c4a68ba377892982cb5cf", "c3a52e31188c43b6930c737fbe8a3026")
        generate_playlist(name)
        lastpl = Playlist.last
        lastpl.user_id = self.id
        if number > 10
            number = 10
        end
        number.times do
            rec = RSpotify::Recommendations.generate(limit: 1, seed_genres: [genre])
            rec_songs = rec.tracks
            if rec_aa = rec_songs.collect{|x| x.album.artists} == []
                puts "Genre not found - try another genre!"
                self.playlist_pick
            else
                rec_aa = rec_songs.collect{|x| x.album.artists}
                rec_aa = rec_aa[0].collect{|x| x.name}
                a = Artist.create(name: rec_aa[0])
                rec_song = rec.tracks.collect{|x| x.name}
                s = Song.create(title: rec_song[0])
                SongsArtists.create(song: s, artist: a)
                PlaylistsSongs.create(playlist: lastpl, song: s)
            end
        end
    end

#Remove Playlist
    def remove_playlist(name)
        if Playlist.where(name: name) == []
            p "No matching playlist."
        else
            Playlist.where(name: name).destroy_all
        end
    end
end