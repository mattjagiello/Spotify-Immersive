# Spotify Immersive :musical_note:
A CLI based app showcasing Spotify, Wikipedia, and Ticketmaster interactivity by [Aaiden Witten](https://github.com/aaidenplays) and [Matt Jagiello](https://github.com/mattjagiello)

![Spotify Immersive Splash Screen](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/finalchanges/images/program%20splash.png)

## Technologies
[Ruby](https://www.ruby-lang.org/en/)

[Active Record](https://guides.rubyonrails.org/active_record_basics.html)

[SQLite3](https://www.sqlite.org/version3.html)

## Getting Started
1. Be sure you have downloaded and [installed Ruby](https://www.ruby-lang.org/en/documentation/installation/) on your computer in order to run Ruby files.
2. Clone this project repo down to your local computer.
3. Navigate to the folder where you downloaded the repo and run `bundle` in your terminal to install the required gems and components for the app.
4. In order to play songs in the Spotify desktop app from from the playlist via the 'play song' CLI option, you will need to install the ['shpotify'](https://github.com/hnarayanan/shpotify) [Homebrew](https://brew.sh/) application using the terminal command `brew install shpotify` or [click here](https://medium.com/@dallasbille/controlling-your-spotify-from-terminal-a505990bafc2) for a walkthrough.
5. Run the command `rake db:migrate` in your terminal to create the local SQLite3 database.
6. Open the app via CLI by running `ruby bin/run.rb`

## Features
- Individual user accounts saved to the local SQLite3 database via Active Record. User accounts are password protected so users will not be able to view/modify the playlists of other users.

![Wrong password](https://raw.githubusercontent.com/mattjagiello/ruby-project-guidelines-austin-web-012720/finalchanges/images/wrong%20password.png)

- Automatically generating playlists by genre from Spotify's recommendation algorithm via API call.

![Generate playlist by genre](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/finalchanges/images/generate%20by%20genre.png)

- CRUD functionality to add/remove/rename playlists from the SQLite3 database and to add/remove songs from individual playlists.

- Ability to open individual songs from playlist in Spotify for playback!

![Play song in Spotify](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/master/images/play_song.png)

- After song playback has started, can view information about artist pulled from their Wikipedia page via API.

![View artist information](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/master/images/view_artist_info.png)

- After song playback has started, able to view artist's next tour date information and a link to the event page pulled from Ticketmaster API.

![View next tour date information](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/master/images/view_artist_tour_date.png)

## Interesting Notes

The play_song method was difficult to wrap our heads around. Would we be able to play music back in the CLI? Did we have to open up a browser with the song URI? After some initial research, we were able to find a [homebrew](https://brew.sh/) package called [‘shpotify’](https://github.com/hnarayanan/shpotify) that was designed specifically for Spotify interaction. Once we downloaded and set it up, all we had to do was add `window(command)` in our Ruby code and we achieved playback in the Spotify desktop app! :metal:

### What We Learned

1. While working on this project we found a plethora of [Ruby gems](https://rubygems.org/) on the web. Several times when attempting to install or configure a gem in the code, it ended up crashing the entire program execution. Our knowledge of working with these gems feels much more solid after this experience.

2. Github has been a looming shadow of hesitance lingering in the back of our collective consciousness since day one. The advantage of working with a partner was learning how to navigate Github and commit/update to the project without overwriting our repo with broken code. Our understanding of Github is still somewhat cloudy but thanks to this project it is starting to clear up.

3. Project planning was the most important factor in this project. Together we learned how to set up complex class and object associations correctly through ActiveRecord. Prioritizing and delegating our development tasks was also a valuable aspect of our process which we did well. We were able to set and complete stretch goals that we vowed not to start until our program was running as a minimum viable product.

### What We Would Change

The most glaring change we would make would be modifying the menu navigation in our program. When planning the project, we didn't fully take into account the user experience when clicking through the program. Additionally, we divided the work of building the methods and class functionality without setting a standard for how user navigation would work. The result of these decisions was a somewhat confusing experience using menu options such as going back to previous menus or stopping the execution of certain methods. Ultimately the program seems to be mostly intuitive as our beta testers and colleagues were able to use the app without great difficulty or assistance.

### Code Highlight
```
#The following code plays a song in spotify through a cli command and stores that song as current song.
    if artist == nil || song == nil
        return "Song is not in #{self.name} playlist"
    else
        system("spotify play #{song} #{artist}")
    end
    #can also accomplish by array index no.-1
    Song.current=(song)
    self.display_playlist_as_table
```
