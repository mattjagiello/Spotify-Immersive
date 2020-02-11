class Playlist < ActiveRecord::Base
    belongs_to :user
    has_and_belongs_to_many :songs

    def add_song(title, artist)
        song = RSpotify::Track.search(title)

        track_found = song.select do |track|
            if track.album.artists[0].name == artist
                track
            end
        end


        #finds artist page
        #uri_found = track_found[0].album.artists[0].uri

        s = Song.create(title: title)
        a = Artist.create(name: artist)
        SongsArtists.create(song: s, artist: a)
        PlaylistsSongs.create(playlist: self, song: s)
    end

    def display_playlist
        songids = PlaylistsSongs.all.map do |row|
            if row.playlist == self
                row.song_id
            end
        end

       song_artist_array = SongsArtists.all.select do |sa_row|
            songids.select do |si_row|
                sa_row.song_id == si_row
            end
        end

        table_data = []

        index = 0

        song_artist_array.each do |sa_row|
            table_data << {songs: sa_row.song.title, artists: sa_row.artist.name, track_no: index+=1 }
        end

        # Formatador.display_table(table_data)
        table_data

    end

    def display_playlist_as_table
        Formatador.display_table(self.display_playlist)
    end

    def play_song(selection_number)
        song = nil
        self.display_playlist.each do |row|
            if row[:track_no] == selection_number
                song = row[:songs]
            end
        end
                                # binding.pry

        artist = nil
        self.display_playlist.each do |row|
            if row[:track_no] == selection_number
                artist = row[:artists]
            end
        end


        if artist == nil || song == nil
            return "Song is not in #{self.name} playlist"
        else
            system("spotify play #{song} #{artist}")
        end
        #can also accomplish by array index no.-1


        # playlist.find

    #     song = playlist.(selection_number-1).

    #     if playlist.include?(selection_number)
    #         title = 
    #         system("spotify play #{title}")
    #     end
    end


end