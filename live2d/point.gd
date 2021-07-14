extends Drag
var color_select=Color.red
var color_normal=Color.green
var color=color_normal
func _on_point_mouse_entered():
	color=color_select
	pass # Replace with function body.
func _on_Drag_input_event(viewport, event, shape_idx):
	._on_Drag_input_event(viewport,event,shape_idx)
func _on_point_mouse_exited():
	color=color_normal
func _process(delta):
	._process(delta)
	update()
func _on_point_input_event(viewport, event, shape_idx):
	._on_Drag_input_event(viewport,event,shape_idx)
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index==BUTTON_LEFT:
			if Global.editor_mode.current_mode=="删除顶点":
				print("删除顶点>对象:",self)
				self.queue_free()
			else:
				return 
func _draw():
	draw_circle(Vector2(0,0),10.0,color)
