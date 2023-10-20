extends Sprite2D

## Get the size of the texture and we'll use it to wrap/loop the sprite
@onready var width = texture.get_size().x
## The speed at which the background scrolls
@export var speed: float = 25
## Time between target spawns
@export var spawn_time_range := Vector2(2, 5)
## Chance of a plain target spawning
@export var plain_target_odds: int = 3

## Plain target scene
@export var plain_target_scene: PackedScene
## Duck target scene
@export var duck_target_scene: PackedScene
## Container for targets
@export var targets_container: Node2D

## Timer for spawning targets
var timer := Timer.new()

func _ready():
	# add the spawn timer to the scene
	add_child(timer)
	# We want to vary the spawn time, so we'll use a one-shot timer
	timer.one_shot = true
	# Connect the timeout signal to the function that spawns targets
	timer.timeout.connect(my_timer_timeout)
	# Start the timer
	timer.start(randf_range(spawn_time_range.x, spawn_time_range.y))


func _process(delta):
	# Move the background and wrap it when it's moved
	region_rect.position.x = wrapf(region_rect.position.x + delta * speed, 0, width)
	

## Runs when our spawn timer times out
func my_timer_timeout():
	# We want to spawn a duck target every time
	var duck_target = duck_target_scene.instantiate()
	targets_container.add_child(duck_target)
	
	# Then occording to the odds, we'll possibly spawn a plain target
	if randi_range(0, plain_target_odds) == 0:
		var plain_target = plain_target_scene.instantiate()
		targets_container.add_child(plain_target)
	
	# The timer is set to one-shot, so we need to restart it
	# This varies the spawn time
	timer.start(randf_range(spawn_time_range.x, spawn_time_range.y))
