extends Sprite
var look=false
func _process(delta):
	if look:
		look_at(get_global_mouse_position())
	pass
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			look=true
		else:
			look=false
