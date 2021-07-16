extends Node2D
func _ready():
	var animation=Animation.new()
	var rotation_value=20
	var key=1
	var time=2
	AnimData.reg_key(rotation_value,key,time,$test)
	AnimData.play()
	#AnimData.test()
