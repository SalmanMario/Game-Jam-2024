extends AudioStreamPlayer2D

# Declare an array to hold the songs
var songs = []
var current_song_index = 0

func _ready():
	# Load the songs into the array
	songs.append(load("res://assets/sounds/Creepy.mp3"))
	songs.append(load("res://assets/sounds/Nautical_Nostalgia_first_draft.mp3"))
	songs.append(load("res://assets/sounds/Silly_Shore.mp3"))

func play_next_song():
	if current_song_index < songs.size():
		stream = songs[current_song_index]
		play()
		current_song_index += 1
	else:
		current_song_index = 0  # Reset to the first song if you want to loop
		play_next_song()  # Start the playlist over

func _on_MusicPlayer_finished():
	# When the current song finishes, play the next one
	play_next_song()


func _on_finished():
	play_next_song()
