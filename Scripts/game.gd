## Main Script for game scene
##
## Holds stats info
class_name Game extends Node2D

## UI ref
@export var ui: UI
## Ammo Display Box
@export var ammo_display: AmmoDisplay
## Timer for ammo regen
@export var ammo_timer: Timer
## Interval for ammo regen
@export var ammo_regen_time: float = .75
## Rifle ref
@export var rifle: Rifle
## Maximum number of bullets
var max_bullets: int = 3
## Current bullet count
@onready var bullets: int = max_bullets:
	set(b):
		bullets = b
		ammo_display.on_bullets_changed()
## Lost Screen
@export var game_over_screen: Control
## Bool for if we just fired
var just_fired: bool = false

## Points for our shot targets
var points: int = 0:
	# Setter for points
	set(p):
		points = p
		# We want to display double digits, so we need to add a 0 if we're less than 10
		var prefix := ""
		if str(points).length() < 2:
			prefix = "0"
		# Update the UI
		ui.score_label.text = prefix + str(points)


## Ducks that can still be missed before game over
var misses_left: int = 3:
	# Setter for misses_left
	set(ml):
		misses_left = ml
		# if we run out of misses, game over
		if misses_left < 0:
			# Show the game over screen
			game_over_screen.visible = true
			# Check if we have a new high score, and save it if we do
			high_score_check()
			# Pause the game so we can't shoot anymore
			get_tree().paused = true
		else:
			# if we still have misses left, update the UI
			ui.misses_label.text = "0" + str(misses_left)


func _ready() -> void:
	# Set the misses left UI
	ui.misses_label.text = "0" + str(misses_left)
	# Set the timer wait time
	ammo_timer.wait_time = ammo_regen_time
	# start the ammo timer
	ammo_timer.start(ammo_regen_time)


## Called when our regen timer runs out
func _on_ammo_timer_timeout() -> void:
	# If we're not at max bullets, add one
	if bullets < max_bullets:
		bullets += 1


## Checks if we have a new high score, and saves it if we do
func high_score_check() -> void:
	if points > Global.save_data.high_score:
		Global.save_data.high_score = points
		Global.save()
