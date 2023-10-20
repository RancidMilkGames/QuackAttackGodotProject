extends ProgressBar

## Get the game node
@onready var game := get_tree().get_first_node_in_group("Game") as Game
## Our ammo regen timer
@export var ammo_timer: Timer


func _ready() -> void:
	# set visible to the respective setting's value
	visible = get_tree().get_first_node_in_group("AmmoRegenCheck").button_pressed


func _process(_delta: float) -> void:
	# set the value of the progress bar to the percentage of time left
	value = 1 - ammo_timer.time_left / game.ammo_regen_time

