extends Node
var frame
var data=[]
var anim_count=0
var current_select:Area2D
var can_process=true
var animationPlayer=AnimationPlayer.new()
var animation=Animation.new()
var property=""
func _ready():
	set_process(false)
	get_tree().current_scene.add_child(animationPlayer)
func test():
	print("测试动画")
	print(animation)
	print(animationPlayer)
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	print(track_index)
	animation.track_set_path(track_index, "test:rect_rotation")
	animation.track_insert_key(track_index, 0.0, 0)
	animation.track_insert_key(track_index, 1, 100)
	animation.length=1
	animation.loop=true
	animationPlayer.add_animation("test",animation)
	animationPlayer.play("test")
func add_anim(anim_name:String,rotation,node:Node):
	animation.resource_name="test"
#旋转值，帧位置 时长 节点
func reg_key(rotation_value:float,key:float,time_length:float,node:Node):
	data.append(rotation_value)
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	print(track_index)
	animation.track_set_path(track_index, str(node.get_path())+":"+property)
	animation.track_insert_key(track_index, 0, 0)
	animation.track_insert_key(track_index, key, rotation_value)
	animation.length=2
	animationPlayer.add_animation("test",animation)
func set_property(value):
	property=value
func remove_anim():
	animation.free()
#计算动画
func play():
	animationPlayer.play("test")
func set_loop(value):
	animation.loop=value
func stop():
	animationPlayer.stop()
