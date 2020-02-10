User.destroy_all
Song.destroy_all
Artist.destroy_all
Playlist.destroy_all

User.create(name: "Matt")
User.create(name: "Aaiden")
User.create(name: "Fred")

Song.create(title: "Lofi 1")
Song.create(title: "Lofi 2")
Song.create(title: "Hifi 1")

Artist.create(name: "Beyonce")
Artist.create(name: "Jay-Z")
Artist.create(name: "Will Smith")

Playlist.create(name: "Playlist 1")
Playlist.create(name: "Playlist 2")
Playlist.create(name: "Playlist 3")