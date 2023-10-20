## Global autoload singleton
##
## Here we store global variables and functions that are used in multiple scenes.
extends Node

## The overlay is a CanvasLayer that is always on top of everything else.
## It contains the options menu and other things that should be accessible from anywhere.
@export var overlay: Overlay
## AudioPlayer for UI sounds
@export var audio_player: AudioStreamPlayer

## Path to the save file
var save_path: String = "user://game-data.res"
## The save data itself
var save_data: GameSave


func _ready() -> void:
	# Load the save file
	save_data = load_save()
	# Update the save file if the version is outdated
	if save_data.version != GameSave.new().version:
		# Make a new save with all the correct properties
		var new_save := GameSave.new()
		# Copy over all the properties that are in both saves
		for property in save_data.save_var_names:
			if new_save.get(property):
				new_save.set(property, save_data.get(property))
		# Now set the new save as the current save
		save_data = new_save
		# Save the new save
		save()


## Save the game
func save() -> void:
	# Open the file
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	# Write the save data to the file
	file.store_var(inst_to_dict(save_data), true)
	# Close the file
	file.close()


## Load the save file
func load_save() -> GameSave:
	# Check if the file exists
	if FileAccess.file_exists(save_path):
		# Open the file
		var file := FileAccess.open(save_path, FileAccess.READ)
		# Make a save var to either store the loaded save or a new empty save
		var content: GameSave

		if file and file != null:
			# If the file exists and is not empty, load the save's data
			var loaded = file.get_var(true)
			content = dict_to_inst(loaded)
		else:
			# If the file is empty or doesn't exist, make a new save
			content = GameSave.new()
		# Close the file
		file.close()

		if content:
			# Return the save
			return content
		else:
			# The code should never reach this point, but just in case, return a new save
			return GameSave.new()
	else:
		# If the file doesn't exist, return a new save
		return GameSave.new()
