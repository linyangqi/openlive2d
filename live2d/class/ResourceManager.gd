extends Node2D
class_name ResourceManager
var res_textures=[]
var res_textures_data
var current_select
var anim_name:String
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
