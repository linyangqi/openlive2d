#复用 拖拽 主循环只有在进入场景树时才有用
extends Area2D
class_name Drag
var is_drag=false
var offest=Vector2.ZERO
var draw_pos:Vector2
var is_enable_test_print=false
func _ready():
	draw_pos=self.position-Vector2(50,50)
	set_process(true)
# warning-ignore:unused_argument
func _process(delta):
	if is_drag:
		self.position=get_global_mouse_position()+offest
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Drag_input_event(viewport, event, shape_idx):
	if is_enable_test_print:
		print_debug("Drag类的input方法被调用")
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_drag=true
			offest=self.position-get_global_mouse_position()
		else:
			is_drag=false
func set_enable_test_print(value:bool):
	is_enable_test_print=value
func _draw():
	pass
