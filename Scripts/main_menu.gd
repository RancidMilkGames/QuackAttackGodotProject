extends Control

## Reference to the game scene
var game_scene := "res://Scenes/Levels/game.tscn"
## Label for the score
@export var score_label: Label
## Button to exit the game
@export var exit: Control


func _ready() -> void:
	# Hide the exit button if the game is running on the web
	if "Web" in OS.get_name():
		exit.visible = false
	
	# Wait for the save data to be loaded
	await get_tree().create_timer(.1).timeout
	# Prefix the score with a 0 if it's less than 10
	var prefix := ""
	if Global.save_data.high_score < 10:
		prefix = "0"
	# Set the score label's text
	score_label.text = prefix + str(Global.save_data.high_score)
	

## Called when the play button is pressed
func _on_play_pressed() -> void:
	# Play the button sound
	Global.audio_player.play()
	# Change the scene to the game scene
	get_tree().change_scene_to_file(game_scene)


## Called when the options button is pressed
func _on_options_pressed() -> void:
	# Play the button sound
	Global.audio_player.play()
	# Show the options overlay
	Global.overlay.options.visible = true


## Called when the quit button is pressed
func _on_quit_pressed() -> void:
	# Play the button sound
	Global.audio_player.play()
	# Quit the game
	get_tree().quit()
