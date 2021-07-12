extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
