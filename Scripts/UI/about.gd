extends PanelContainer


## signal callback for when the user clicks on a link in the rich text label
## this is used to open the link in the user's default browser
func _on_rich_text_label_meta_clicked(meta) -> void:
	OS.shell_open(str(meta))


## signal callback for when the user clicks on the close button
func _on_close_pressed() -> void:
	# hide the panel
	visible = false
