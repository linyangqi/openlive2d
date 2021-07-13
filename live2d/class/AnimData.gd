class_name AnimData
#var anim_name:String
var animation:Animation
var frame
#编辑器内部使用anim tres处理
func add_anim(anim_name):
	animation=Animation.new()
	animation.resource_name=anim_name
	print("新建动画资源名称>",animation.resource_name)
	animation.add_track(Animation.TYPE_VALUE,0)
	return animation
#注册动画
func reg_key(node_path:String,value):
	animation.track_set_path(0, "Enemy:position:x")
	animation.track_insert_key(0, 0.0, 0)
	animation.track_insert_key(0, 0.5, 100)
	return animation
func remove_anim():
	animation.free()
