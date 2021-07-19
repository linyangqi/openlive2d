extends Line2D
var offest
var drag=false
func _process(delta):
	if drag:
		print("全局x",get_global_mouse_position().x)
		self.position.x=get_global_mouse_position().x
		print("自身x",self.position.x)
		#self.position.x=get_global_mouse_position().x
func _on_HBoxContainer_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			drag=true
			#offest=self.position.x+get_global_mouse_position().x
		else:
			drag=false
