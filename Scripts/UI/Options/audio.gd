extends Control

## Slider for adjusting music volume
@export var music_vol_slider: HSlider
## Slider for adjusting SFX volume
@export var sfx_vol_slider: HSlider

## Audio player for previewing music volume
@export var music_preview_player: AudioStreamPlayer


## Called when the player stops dragging the music volume slider
func _on_music_slider_drag_ended(_value_changed) -> void:
	# Set the volume of the music bus to the value of the slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_vol_slider.value)
	# Save the new volume to the options file
	Global.overlay.options.save()
	# Play the preview music
	music_preview_player.play()


## Called when the player stops dragging the SFX volume slider
func _on_sfx_slider_drag_ended(_value_changed) -> void:
	# Set the volume of the SFX bus to the value of the slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_vol_slider.value)
	# Save the new volume to the options file
	Global.overlay.options.save()
	# Play the preview music
	Global.audio_player.play()
