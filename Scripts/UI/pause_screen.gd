extends PanelContainer

## path to the main menu scene
var main_menu_scene := "res://Scenes/Levels/main_menu.tscn"


## Called when the quit button is pressed.
func _on_quit_pressed():
	# unpause the game so that the main menu works
	get_tree().paused = false
	# change the scene to the main menu
	get_tree().change_scene_to_file(main_menu_scene)


## Called when the options button is pressed.
func _on_options_pressed():
	# Make the options menu visible
	Global.overlay.options.visible = true


## Called when the resume button is pressed.
func _on_resume_pressed():
	# hide the pause menu
	visible = false
	# unpause the game
	get_tree().paused = false


func _on_visibility_changed():
	# pause the game when the pause menu is visible
	# unpause the game when the pause menu is not visible
	get_tree().paused = visible
	if not visible:
		# hide the options menu when the pause menu is closed
		Global.overlay.options.visible = false
