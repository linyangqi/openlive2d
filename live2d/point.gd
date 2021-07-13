extends Area2D

func _ready():
	pass 
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_point_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index==BUTTON_LEFT:
			self.position=event.position
	if event is InputEventMouseMotion:
		#self.position=event.position
		pass
	pass # Replace with function body.


func _on_point_mouse_entered():
	$CanvasModulate.color=Color(0.219608, 0.698039, 0.180392)
	pass # Replace with function body.


func _on_point_mouse_exited():
	$CanvasModulate.color=Color(1,1,1)
	pass # Replace with function body.
