## Rifle logic and FX
##
## Basically just positioning and FX for rifle
class_name Rifle extends Sprite2D

## Offset from mouse/crosshair
var mouse_offset: Vector2 = Vector2(200, 250)
## End of Gun
@export var muzzle_end: Node2D
## Audio player for SFX
@export var audio_player: AudioStreamPlayer2D

## Particle FX for barrel smoke
@export var smoke_fx_scene: PackedScene
## Particle FX for combustion effect
@export var fire_fx_scene: PackedScene


func _process(_delta) -> void:
	# Just follows the mouse around
	position = get_viewport().get_mouse_position() + mouse_offset

## FX to play when we fire the gun
func fire() -> void:
	# Instantiate FX from packed scenes
	var smoke: CPUParticles2D = smoke_fx_scene.instantiate() as CPUParticles2D
#	var fire_fx: CPUParticles2D = fire_fx_scene.instantiate() as CPUParticles2D
	
	# Add to scene
	muzzle_end.add_child(smoke)
#	add_child(fire_fx)
	
	# Set position to where effect should be
	smoke.global_position = muzzle_end.global_position
#	fire_fx.global_position = muzzle_end.global_position
	
	# Start effect
	smoke.emitting = true
#	fire_fx.emitting = true
	
	# Play fire noise
	audio_player.play()
	await get_tree().create_timer(1).timeout
	
	# Cleanup
	smoke.queue_free()
#	fire_fx.queue_free()
