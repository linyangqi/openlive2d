extends Panel
func _ready():
	
	pass
func _on_Node2D_sync_anim_add(anim_name):
	var option_anims=get_node("root_vbox/control_bar/switch_anim")
	var tree=option_anims.add_item(anim_name)
	$root_vbox/tip.hide()
	$root_vbox/main_view.show()
func _on_anim_edit_pressed():
	get_node("PopupMenu").popup()

#展开
func _on_switch_scale_toggled(button_pressed):
	if button_pressed:
		margin_top=0
	else:
		margin_top=400
func _on_add_track_pressed():
	$ask_addTrack.popup()
#添加轨道
func _on_ask_addTrack_id_pressed(id):
	print_debug(id)
	if id==0:
		$ask_addTrackNode.popup()
#选中要编辑的节点
func _on_ok_pressed():
	pass # Replace with function body.
