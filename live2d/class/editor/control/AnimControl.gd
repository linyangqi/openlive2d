extends Node

var animation:Animation
var animPlayer:AnimationPlayer
func _ready():
	animPlayer=get_tree().current_scene.get_node("AnimationPlayer")
#添加动画 动态生成动画 动画名  节点  在第几秒注册 属性 值
func add_anim(anim_name,node,reg_key_time,property,value):
	animation=Animation.new()
	animation.resource_name=anim_name
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	print(track_index)
	animation.track_set_path(track_index, str(node.get_path())+":"+property)
	animation.track_insert_key(track_index, 0, 0)
	animation.track_insert_key(track_index, reg_key_time, value)
	animPlayer.add_animation(anim_name,animation)
	AnimData.anim_datas.append(animation)
func set_loop(index,value):
	AnimData.anim_datas[index].loop=value
func play(index):
	animPlayer.play(AnimData.anim_datas[index].resource_name)
func stop():
	animPlayer.stop()
#设置动画时长
func set_time_length(value):
	animation.length=value
	print("时长>",value)
#测试动画
func test():
	print("测试动画")
	print(animation)
	print(animPlayer)
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	print(track_index)
	animation.track_set_path(track_index, "test:rect_rotation")
	animation.track_insert_key(track_index, 0.0, 0)
	animation.track_insert_key(track_index, 1, 100)
	animation.length=1
	animation.loop=true
	animPlayer.add_animation("test",animation)
	animPlayer.play("test")
