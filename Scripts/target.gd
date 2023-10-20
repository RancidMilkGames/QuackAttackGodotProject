## Targets the player aims at
##
## Base for the different targets
class_name Target extends CharacterBody2D

## The different modes the target can be in
enum MODES { ALIVE, DEAD }
## The current mode of the target
var current_mode: MODES = MODES.ALIVE

## Range of the speed at which the target can move
@export var speed_range := Vector2(5, 10)
## Speed the target moves at, randomly chosen in the speed range
@onready var speed := randf_range(speed_range.x, speed_range.y)

## Range of the amplitude of the target's movement. For the bobbing effect
@export var amp_range := Vector2(.5, 1.5)
## Amplitude of the target's movement, randomly chosen in the amplitude range
@onready var amplitude := randf_range(amp_range.x, amp_range.y)

## Sprite for the bullet hole
@export var bullet_hit_sprite: Sprite2D
## Sprite for the target
@export var target_sprite: Sprite2D

## Particles for the bullet hit
@export var hit_fx: CPUParticles2D
## Audio player for the bullet hit sound
@export var audio_player: AudioStreamPlayer2D

## The game node
@onready var game := get_tree().get_first_node_in_group("Game") as Game

## Gravity for when the target is dead(hit)
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") as float


func _ready() -> void:
	# adjust the target's position so the stick is covered by the water
	position.y += 25
	# Hide the bullet hole sprite
	bullet_hit_sprite.visible = false


func _physics_process(delta: float) -> void:
	# Match logic based on current mode
	match current_mode:
		# If the target has been hit, apply gravity
		MODES.DEAD:
			velocity.y += gravity * delta
	move_and_slide()


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	# If the player clicks on the target, and the target is alive, and the player has just fired
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and current_mode == MODES.ALIVE \
	and game.just_fired:
		# The target has been hit, set it to dead
		current_mode = MODES.DEAD
		# Show the bullet hole sprite
		bullet_hit_sprite.visible = true
		# Set the bullet hole sprite's position to the mouse position
		bullet_hit_sprite.global_position = (event as InputEventMouseButton).position
		# Start the bullet hit particles
		hit_fx.emitting = true
		# Play the bullet hit sound
		audio_player.play()
		# Wait for the target to fall off the screen
		await get_tree().create_timer(1).timeout
		# Remove the target from the scene
		queue_free()
		

