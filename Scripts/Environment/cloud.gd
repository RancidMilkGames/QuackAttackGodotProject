extends Sprite2D

## Range that the speed can be
@export var speed_range := Vector2(5, 10)
## Set the speed to a random value between the range
@onready var speed := randf_range(speed_range.x, speed_range.y)


func _process(delta: float) -> void:
	# Move sprite across the screen
	position.x += speed * delta
	# If the sprite goes off the screen, reset it to the left side
	if position.x > 1280:
		position.x = 0
