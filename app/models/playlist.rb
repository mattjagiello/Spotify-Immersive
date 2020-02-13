require_relative 'user.rb'
require 'wikipedia'

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

        s = Song.create(title: title)
        a = Artist.create(name: artist)
        SongsArtists.create(song: s, artist: a)
        PlaylistsSongs.create(playlist: self, song: s)

        self.display_playlist_as_table
    end

    def display_playlist
        songids = PlaylistsSongs.all.map do |row|
            if row.playlist == self
                row.song_id
            end
        end
        
        song_artist_array = []
       SongsArtists.all.map do |sa_row|
            songids.each do |si_row|
                if sa_row.song_id == si_row
                    song_artist_array << sa_row
                end
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
        if Song.current != nil
            Formatador.display_line('[green]now playing')
            p Song.current
        end
        self.display_options
    end

    def play_song(selection_number)
        song = nil
        self.display_playlist.each do |row|
            if row[:track_no] == selection_number
                song = row[:songs]
            end
        end

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
        Song.current=(song)
        self.display_playlist_as_table
    end

    def rename_playlist(name)
        self.update(name: name)
    end

    
    def delete_song(selection_number)
        song = nil
        self.display_playlist.each do |row|
            if row[:track_no] == selection_number
                song = row[:songs]
            end
        end


        PlaylistsSongs.all.each do |pls|
            if pls.song.title == song && pls.playlist == self
                pls.destroy
            end
        end
        self.display_playlist_as_table
    end

    def current_artist
        SongsArtists.all.each do |sa|
            if sa.song.title == Song.current
                return sa.artist
            end
        end
    end

    def display_options
        prompt = TTY::Prompt.new
        selection = prompt.select('Select command') do |menu|
            menu.choice name: 'play song',  value: 1
            menu.choice name: 'add song', value: 2
            menu.choice name: 'delete song',  value: 3
            menu.choice name: 'read current artist info', value: 4
            menu.choice name: 'rename',  value: 5
            menu.choice name: 'back',  value: 6
            menu.choice name: 'EXIT', value: 7
        end

        case selection
        when 1
            input = prompt.ask('Enter song no.:')
            self.play_song(input.to_i)
        when 2
            song_title = prompt.ask('Enter song title:')
            artist_name = prompt.ask('Enter artist name:')
            self.add_song(song_title, artist_name)
            self.display_playlist_as_table
        when 3
            input = prompt.ask('Enter song no. to delete:')
            self.delete_song(input.to_i)
            self.display_playlist_as_table
        when 4
            self.current_artist.read_info
        when 5
            input = prompt.ask('Enter new name for playlist:')
            rename_playlist(input)
            puts "renamed playlist to #{self.name}"
        when 6
            user = nil
            User.all.each do |u|
                if u == self.user
                    user = self.user
                end
            end
            user.view_playlists_as_table
        when 7
            exit
        end
    end


end