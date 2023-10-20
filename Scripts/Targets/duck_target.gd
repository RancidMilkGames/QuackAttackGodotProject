extends Target

## Black and white duck texture for modulating colors
@export var duck_texture_bw: Texture2D
## Chance of more difficult duck
@export var mutation_probability := Vector2(4, 7)

func _ready():
	# Call parent's _ready
	super()
	# Start the duck at the beginning of the screen
	position.x = -640
	
	# Generate a random number to determine if the duck is more difficult
	var rand := randi_range(0, int(mutation_probability.y))
	# If the random number is more than the mutation probability, make the duck more difficult
	if rand > mutation_probability.x:
		# Set the duck's texture to the black and white texture so we can modulate the color
		target_sprite.texture = duck_texture_bw
		if rand == mutation_probability.y:
			# Check if the random number is high enough to make the duck even more difficult
			# If so, make the duck red and double its speed
			target_sprite.self_modulate = Color("ff0000")
			speed *= 2
		else:
			# The duck is more difficult, but not as difficult as the red duck
			# Make the duck orange and increase its speed by 50%
			target_sprite.self_modulate = Color("ff8800")
			speed *= 1.5


func _physics_process(delta: float) -> void:
	# Call parent's _physics_process
	super(delta)

	# Run logic based on the current mode
	match current_mode:
		MODES.ALIVE:
			# If the duck is alive, move it across the screen
			velocity.x = delta * speed * 1000
			# Make the duck bob up and down
			position.y += sin((PI * (get_tree().get_frame())) / 30) * amplitude / 2 * PI
	# If the duck makes it to the end of the screen, the player loses a miss
	if position.x > 640:
		game.misses_left -= 1
		# Remove the duck from the scene
		queue_free()


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	# wait a frame to check if the player has fired.
	# We need to wait a frame to make sure the the player has a bullet to fire
	await get_tree().process_frame
	# If the fire button is pressed, the duck is alive, and the player has fired
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and current_mode == MODES.ALIVE \
	and game.just_fired:
		# call the parent's _on_input_event
		super(_viewport, event, _shape_idx)
		# Stop the duck from moving forward so it doesn't get past the end of the screen
		# Only really necessary for ducks near the end of the screen
		velocity.x = 0
