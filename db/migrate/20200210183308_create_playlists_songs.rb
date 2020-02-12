class CreatePlaylistsSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists_songs do |t|
      t.integer :playlist_id
      t.integer :song_id
    end
  end
end
