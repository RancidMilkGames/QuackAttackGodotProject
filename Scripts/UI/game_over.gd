extends PanelContainer

## Path to the main menu scene.
var main_menu_scene := "res://Scenes/Levels/main_menu.tscn"


## Called when quit button is pressed.
func _on_quit_pressed() -> void:
	# un-pause so the main menu will work
	get_tree().paused = false
	# change scene to main menu
	get_tree().change_scene_to_file(main_menu_scene)


## Called when play again button is pressed.
func _on_again_pressed() -> void:
	# Reload the current scene.
	get_tree().reload_current_scene()
	# un-pause so the game will work
	get_tree().paused = false
