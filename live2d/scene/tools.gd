extends HBoxContainer
var is_drag=false
var offest=Vector2(5,5)
func _process(delta):
	if is_drag:
		self.rect_position=get_global_mouse_position()-offest
		print(self.rect_position)
func _on_Label_gui_input(event):
	if event is InputEventMouseButton:
		is_drag=true
		#offest=get_global_mouse_position()
	else:
		is_drag=false
	pass 
