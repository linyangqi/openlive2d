extends Node2D
signal select_bone(bone)
var is_drag=false
var offest=Vector2.ZERO
var draw_pos:Vector2
func _ready():
	draw_pos=self.position-Vector2(50,0)
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print_debug("发送选中骨骼信号：",self)
			emit_signal("select_bone")
			is_drag=true
			offest=self.position-get_global_mouse_position()
		else:
			is_drag=false
	pass 
# warning-ignore:unused_argument
func _process(delta):
	if is_drag:
		self.position=get_global_mouse_position()+offest
func _draw():
	draw_rect(Rect2(draw_pos,Vector2(100,100)),Color.red,false,2.0)
	pass
func draw_rotate_tool():
	pass
