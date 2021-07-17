extends Panel
signal add_anim
func _on_cancel_pressed():
	hide()
func _on_new_anim_pressed():
	var anim_name=get_node("PanelContainer/anime_name").text
	emit_signal("add_anim",anim_name)
func _on_alert_new_anim_pressed():
	show()
