extends Node2D
func _ready():
	var animation=Animation.new()
	var rotation_value=20
	var key=1
	var time=2
	#AnimData.test()
	AnimData.set_loop(true)
	AnimData.set_reg_key_time(2.0)
	AnimData.set_time_length(4)
	AnimData.set_property("rect_rotation")
	AnimData.reg_key(180,$TextureRect)
	AnimData.play()
