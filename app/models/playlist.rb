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

        s = Song.create(title: title, uri: uri_found)
        a = Artist.create(name: title)
        SongsArtists.create(song: s, artist: a)
        PlaylistsSongs.create(playlist: self, song: s)
    end

    def play_song(selection_number)
        key_id = self.id
        
        system("spotify play #{title}")
    end


end