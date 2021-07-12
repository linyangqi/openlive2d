extends Area2D
var is_drag=false
var offest=Vector2.ZERO
func _process(delta):
	if is_drag:
		self.position=get_global_mouse_position()+offest
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_drag=true
			offest=self.position-get_global_mouse_position()
		else:
			is_drag=false
	pass # Replace with function body.
