extends Node2D
signal select_bone(bone)
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print_debug("发送选中骨骼信号：",self)
			emit_signal("select_bone")
	pass # Replace with function body.


func _on_Node2D_tree_entered():
	#print("进入场景树")
	pass # Replace with function body.
