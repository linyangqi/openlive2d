extends Node2D
var mode=""
#时间轴缩放
var time_scale=1
#每次缩放的量
var scale_size=0.02
var key_nodes=[]
func _ready():
	mode=""
	pass
func play():
	
	pass
func _process(delta):
	if mode=="play":
		$TimeLine.position.x+=1
	pass


func _on_play_pressed():
	mode="play"
	pass # Replace with function body.


func _on_scale_add_pressed():
	time_scale+=scale_size
	$HBoxContainer.set("custom_constants/separation",time_scale)
	print(time_scale)
	for i in key_nodes:
		print(i)
		i.position.x*=time_scale
func _on_scale_min_pressed():
	time_scale-=scale_size
	print(time_scale)
	$HBoxContainer.set("custom_constants/separation",time_scale)
	for i in key_nodes:
		print(i)
		i.position.x*=time_scale
func _on_reg_pressed():
	var key=load("res://live2d/control/Key.tscn").instance()
	key.position.x=$TimeLine.position.x
	add_child(key)
	key_nodes.append(key)
	pass 
