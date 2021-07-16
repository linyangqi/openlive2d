extends Node
var frame
var data=[]
var anim_count=0
var current_select:Area2D
var can_process=true
var animationPlayer=AnimationPlayer.new()
var animation=Animation.new()
func _ready():
	set_process(false)
#编辑器内部使用anim tres处理
func add_anim(anim_name:String,rotation,node:Node):
	animation.resource_name="test"
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	var nodePath=node.get_path()
	print("节点路径",nodePath)
	print(node.name)
	animation.track_set_path(track_index, "Node2D/"+node.name+":rotation_degrees")
	animation.track_insert_key(track_index, 0.0, 0)
	animation.track_insert_key(track_index, 1, 100)
	animation.length=1
	animation.loop=true
	animationPlayer.add_animation("test",animation)
func reg_key(rotation_value):
	data.append(rotation_value)
func _process(delta):
	if can_process():
		
		pass
	else:
		print("不可以播放")

func remove_anim():
	animation.free()
#计算动画
func caculate_anim():
	animationPlayer.play("test")
	pass
func stop_caculate():
	can_process=false
	set_process(false)
