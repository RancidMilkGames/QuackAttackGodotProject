extends Target

# Range of time in seconds that the target will be visible
var view_time_range := Vector2(1, 2)
# Tween for showing and hiding the target
@onready var tween := create_tween()


func _ready():
	# Call the parent's _ready() function
	super()
	
	# Give the target a random position
	position.x = randi_range(-500, 500)
	# Move the target so that the bottom of the target is hidden by water
	position.y += 200
	
	# Tween the target to move up to its sitting position
	tween.tween_property(self, "position:y", position.y - 200, .6).set_trans(Tween.TRANS_ELASTIC) #TRANS_BOUNCE)
	# Wait for the tween to finish
	await tween.finished
	# Kill the tween
	tween.kill()
	# Wait for the target to be visible for a random amount of time in the range
	await get_tree().create_timer(randf_range(view_time_range.x, view_time_range.y)).timeout
	
	# Make a new tween so we can tween the target's position again
	tween = create_tween()
	# Tween the target to move down to its hiding position
	tween.tween_property(self, "position:y", position.y + 200, .3)
	# Wait for the tween to finish
	await tween.finished
	# Remove the target from the scene and free it
	queue_free()

## Commented out because it's just overriding the parent's function to call the parent's function
# func _physics_process(delta):
# 	super(delta)


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	# wait a frame to check if the player has fired.
	# We need to wait a frame to make sure the the player has a bullet to fire
	await get_tree().process_frame
	# If the fire button is pressed, the duck is alive, and the player has fired
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and current_mode == MODES.ALIVE \
	and game.just_fired:
		# Kill the tween so that the target doesn't move down to its hiding position
		tween.kill()
		# Add a point scored
		game.points += 1
		# Run parent's _on_input_event() function
		super(_viewport, event, _shape_idx)
