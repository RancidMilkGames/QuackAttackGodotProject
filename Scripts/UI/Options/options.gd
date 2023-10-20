## Options menu
##
## Contains options for the game
##

class_name Options extends PanelContainer

## Config file for saving settings
var config := ConfigFile.new()


func _ready():
	# Load config file
	var err := config.load("user://settings.cfg")
	# If config file doesn't exist, create it with default values
	if err != OK:
		config.set_value("Options", "music_volume", 0)
		config.set_value("Options", "sfx_volume", 0)
		config.set_value("Options", "display_progress", false)

		# Save config file
		config.save("user://settings.cfg")
	# Load values from config file and change their respective values in the menu
	else:
		%MusicHSlider.value = config.get_value("Options", "music_volume")
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), %MusicHSlider.value)
		
		%SFXHSlider.value = config.get_value("Options", "sfx_volume")
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), %SFXHSlider.value)
		
		var ammo_regen_check = get_tree().get_first_node_in_group("AmmoRegenCheck")
		ammo_regen_check.button_pressed = config.get_value("Options", "display_progress")


## Saves the settings to the config file
func save():
	config.set_value("Options", "music_volume", %MusicHSlider.value)
	config.set_value("Options", "sfx_volume", %SFXHSlider.value)
	config.set_value("Options", "display_progress", %RegenProgCheckBox.button_pressed)

	config.save("user://settings.cfg")


## Runs when the close button is pressed
func _on_close_pressed() -> void:
	Global.audio_player.play()
	visible = false


## Runs when the tab is changed
func _on_tab_container_tab_changed(_tab: int) -> void:
	# Play sound
	Global.audio_player.play()


func _on_visibility_changed() -> void:
	# if escape is pressed in-game, while paused, the game will be unpaused
	# and we need to make sure to hide all non-pause menu elements
	if not visible:
		Global.overlay.about.visible = false
