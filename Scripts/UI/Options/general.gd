extends Control

## Runs when the player presses the "Options" button in the pause menu.
func _on_about_button_pressed() -> void:
	# Show the about screen.
	Global.overlay.about.visible = true


## Runs when the player toggles the "Show Ammo Regen Progress" checkbox.
func _on_regen_prog_check_box_toggled(button_pressed) -> void:
	# Show or hide the ammo regen progress bar.
	if get_tree().get_first_node_in_group("AmmoRegenProg"):
		get_tree().get_first_node_in_group("AmmoRegenProg").visible = button_pressed

	# Save the new setting.
	Global.overlay.options.save()
