extends Area2D
var drag=false
func _process(delta):
	if drag==true:
		#只移动x坐标
		self.position.x=get_global_mouse_position().x
	pass
func _on_Drag_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print("拖动")
			drag=true
		else:
			drag=false
