extends PointLight2D

## Enum for the direction of the light's movement
enum DIRECTIONS { FORWARD, BACKWARD }
## The current direction of the light's movement
@export var current_direction: DIRECTIONS = DIRECTIONS.FORWARD

## The speed of the light's movement
@export var speed: float = 50


func _process(delta: float) -> void:
	# Delta position for the light
	var movement := speed * delta
	
	# Move light based on current direction
	match current_direction:
		DIRECTIONS.FORWARD:
			position.x += movement
			# If the light has reached the end of the screen, change direction
			if position.x > 1280:
				current_direction = DIRECTIONS.BACKWARD
		DIRECTIONS.BACKWARD:
			position.x -= movement
			# If the light has reached the start of the screen, change direction
			if position.x < 0:
				current_direction = DIRECTIONS.FORWARD
