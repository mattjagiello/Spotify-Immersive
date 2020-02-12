class Song < ActiveRecord::Base
    has_and_belongs_to_many :playlists
    has_and_belongs_to_many :artists
    has_and_belongs_to_many :genres

    # attr_accessor :current

    @@current = nil

    def self.current
        @@current
    end
    
    def self.current=(data)
        @@current = data
    end
end