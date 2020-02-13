# Spotify Immersive :musical_note:
A CLI based app showcasing Spotify and Wikipedia interactivity by [Aaiden Witten](https://github.com/aaidenplays) and [Matt Jagiello](https://github.com/mattjagiello)
![Spotify Immersive Splash Screen](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/finalchanges/images/program%20splash.png)

## Technologies
[Ruby](https://www.ruby-lang.org/en/)

[Active Record](https://guides.rubyonrails.org/active_record_basics.html)

[SQLite3](https://www.sqlite.org/version3.html)

## Getting Started
1. Be sure you have downloaded and [installed Ruby](https://www.ruby-lang.org/en/documentation/installation/) on your computer in order to run Ruby files.
2. Clone this project repo down to your local computer.
3. Navigate to the folder where you downloaded the repo and run `bundle` in your terminal to install the required gems and components for the app.
4. What you need to play songs???
5. Run the command `rake db:migrate` in your terminal to create the local SQLite3 database.
6. Open the app via CLI by running `ruby bin/run.rb`

## Features
- Individual user accounts saved to the local SQLite3 database via Active Record. User accounts are password protected so users will not be able to view/modify the playlists of other users.
![Wrong password](https://raw.githubusercontent.com/mattjagiello/ruby-project-guidelines-austin-web-012720/finalchanges/images/wrong%20password.png)
- Automatically generating playlists by genre from Spotify's recommendation algorithm via API call.
![Generate playlist by genre](https://github.com/mattjagiello/ruby-project-guidelines-austin-web-012720/blob/finalchanges/images/generate%20by%20genre.png)
- CRUD functionality to add/remove/rename playlists from the SQLite3 database and to add/remove songs from individual playlists.
- Ability to open individual songs from playlist in Spotify for playback!
screenshot here
- After song playback has started, can view information about artist pulled from their Wikipedia page via API.
screenshot here

## Interesting Notes
- Describe something you struggled to build, and show us how you ultimately implemented it in your code.
The play_song method was difficult to wrap our mind around. We had to first research how to even operate Spotify from the CLI. Luckily, there was a brew online called ‘shpotify’ that was designed specifically for that task. Once downloaded all we had to do was window(command) in our ruby code and voila!
- Discuss 3 things you learned in the process of working on this project.
While working on this project we found a plethora of gems on the web. This was our first time requiring and installing them without help from a instructor or lab. 
Github has been a looming shadow of hesitance lingering in the back of my consciousness since day one. While working on this project with a partner we learned how to navigate github at a pretty decent rate. Our understanding of github is still somewhat cloudy but thanks to this project it is starting to clear up.
Project planning was the quintessential objective for this project. Together we learned how to set up object associations through ActiveRecord. Prioritizing was also a valuable aspect of our process which I feel we did well. Setting stretch goals that we vowed not to start until our program was running in at least its most child but functioning state.
- Address, if anything, what you would change or add to what you have today?
We really wanted to add a method that returned a list of tour dates for artists passed in. The only problem was Songkick takes up to 7 days to respond to a request for a key. We applied but the key came after the deadline has already passed.
- Present any code you would like to highlight.
