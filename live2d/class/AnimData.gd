extends Node
#var anim_name:String
var animation:Animation
var frame
var data=[]
var anim_count=0
var current_select:Area2D
func _ready():
	set_process(false)
#编辑器内部使用anim tres处理
func add_anim(anim_name:String,rotation,node):
	data.append(rotation)
	current_select=node
	anim_count+=1
	pass
func _process(delta):
	if is_instance_valid(current_select)==true:
		current_select.rotate(deg2rad(300*delta))
	pass
#注册动画
func reg_key(node_path:String,value):
	animation.track_set_path(0, "Enemy:position:x")
	animation.track_insert_key(0, 0.0, 0)
	animation.track_insert_key(0, 0.5, 100)
	return animation
func remove_anim():
	animation.free()
#计算动画
func caculate_anim():
	for i in data:
		print(i)
	if anim_count>1:
		set_process(true)
	pass
