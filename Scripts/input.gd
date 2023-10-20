extends Node

## Reference to the game node
@onready var game := get_parent() as Game


func _input(event: InputEvent) -> void:
	# If the player presses the fire button, try to fire
	if event is InputEventMouseButton \
	and (event as InputEventMouseButton).button_mask == 1 \
	# Check the game is not paused
	and not get_tree().paused \
	# Check the player has bullets left
	and game.bullets > 0:
		# Subtract a bullet
		game.bullets -= 1
		# Set the just fired flag to true
		# The targets are setup just to check if they've been clicked
		# They await a frame and check that the gun had ammo when they were clicked
		game.just_fired = true
		# Fire the gun. This function is just for FX
		game.rifle.fire()
		# Wait a very short time for the targets to check if they've been clicked
		await get_tree().create_timer(.1).timeout
		# Reset the just fired flag
		game.just_fired = false
		
	# If escape is pressed, toggle the pause screen
	elif event.is_action_pressed("ui_cancel"):
		game.ui.pause_screen.visible = not game.ui.pause_screen.visible
		
