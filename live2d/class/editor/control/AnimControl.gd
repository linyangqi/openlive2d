extends Node

var animation:Animation
var animPlayer:AnimationPlayer
var track_index
var tmp_node
func _ready():
	animPlayer=get_tree().current_scene.get_node("AnimationPlayer")
#添加动画 动态生成动画 动画名  节点 动画轨道类型
func add_anim(anim_name,node:Node,track_type):
	animation=Animation.new()
	animation.resource_name=anim_name
	tmp_node=node
	#可以添加不同的轨道 动画播放轨道 声音播放轨道 函数调用轨道 等
	track_index=animation.add_track(track_type)
	animation.track_insert_key(track_index, 0, 0)
	animPlayer.add_animation(anim_name,animation)
	AnimData.anim_datas.append(animation)
	print("添加动画轨道:序号>",track_index)
# 在第几秒注册 属性 值
func reg_key(reg_key_time,property,value):
	animation.track_set_path(track_index, str(tmp_node.get_path())+":"+property)
	animation.track_insert_key(track_index, reg_key_time, value)
	pass
#清除该动画所有轨道
func clear():
	animation.clear()
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
