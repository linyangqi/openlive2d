class_name ResourceManager
var res_textures=[]
var res_textures_data
var current_select
var anim_name:String
#图层 资源 动画 骨骼
var layer_control:Control
var res_control:Control
var anim_control:Control
var bone_control:Tree
#右侧gui控制 nodes[] 共有4种资源 4个面板容器
func init_gui(array):
	layer_control=array[0]
	res_control=array[1]
	anim_control=array[2]
	bone_control=array[3]

func add_resource(res_rect:TextureRect):
	var json={"name":res_rect.name,"texture":res_rect.texture}
	var res_textures_data=to_json(json)
	res_textures.append(res_textures_data)
	#get_tree().current_scene.add_child(res_rect)
	pass
func sync_remove_texture_data():
	res_textures.erase()
#重命名按钮
func rename_btn(in_name:String):
	print_debug(current_select)
	current_select.text=in_name
	pass
func remove_resource(node:Control,res_rect:TextureRect,area:Area2D):
	print("删除资源!")
	node.queue_free()
	res_rect.queue_free()
	area.queue_free()
