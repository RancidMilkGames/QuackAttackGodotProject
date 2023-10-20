class_name AmmoDisplay extends HBoxContainer

## Get a reference to the Game node
@onready var game := get_tree().get_first_node_in_group("Game") as Game

## Textures for the bullet TextureRects
@export var bullet_text_rects: Array[TextureRect]

## Bullet texture for the TextureRects
@export var bullet_texture: Texture2D
## Empty bullet texture for the TextureRects
@export var empty_texture: Texture2D

## Called when the player's bullet count changes
func on_bullets_changed() -> void:
	# Update the bullet TextureRects to reflect the player's current bullet count
	for i in game.max_bullets:
		if game.bullets >= i + 1:
			bullet_text_rects[i].texture = bullet_texture
		else:
			bullet_text_rects[i].texture = empty_texture
