extends Node
var res_textures=[]
var res_textures_data
var current_select
var anim_name:String
#图层 资源 动画 骨骼
var layer_control:ScrollContainer
var res_control:Control
var anim_control:Control
var bone_control:Tree
#右侧gui控制 nodes[] 共有4种资源 4个面板容器 4个按钮
var btn_add:Button
#添加图层
func add_layer(node):
	anim_control.get_node("anime_vbox").add_child(node)
	pass
func import_resource_to_manager(node):
	res_control.get_node("res_layer").add_child(node)
	pass
func init_gui(root:Node):
	layer_control=root.find_node("layer_scroll")
	res_control=root.find_node("res_content")
	anim_control=root.find_node("animes")
	bone_control=root.find_node("ske_tree")
	print("初始图层管理器>",layer_control)
	print("初始资源管理器>",res_control)
	print("初始动画管理器>",anim_control)
	print("初始骨骼管理器>",bone_control)
	var btn_layer=root.find_node("layer")
	var btn_res=root.find_node("resource")
	var btn_bone=root.find_node("bone")
	var btn_anim=root.find_node("animation")
	btn_add=root.find_node("add")
	print("链接信号！")
	btn_layer.connect("pressed",self,"switch_to_layer",[btn_layer])
	btn_res.connect("pressed",self,"switch_to_layer",[btn_layer])
	btn_bone.connect("pressed",self,"switch_to_layer",[btn_layer])
	btn_anim.connect("pressed",self,"switch_to_layer",[btn_layer])
	#添加各种资源按钮
	btn_add.connect("pressed",self,"add_res",[btn_layer])
#各种管理器的切换 下次重构尝试使用tab Container重构
func switch_to_layer(btn_layer:Button):
	#获取button group中选中的按钮
	var pressed_button_name=btn_layer.group.get_pressed_button().name
	print(btn_layer.group)
	print("选中的按钮",pressed_button_name)
	match pressed_button_name:
		"layer":
			btn_add.disabled=false
			layer_control.show()
			res_control.hide()
			bone_control.hide()
			anim_control.hide()
		"resource":
			btn_add.disabled=false
			res_control.show()
			layer_control.hide()
			bone_control.hide()
			anim_control.hide()
		"bone":
			btn_add.disabled=false
			bone_control.show()
			layer_control.hide()
			res_control.hide()
			anim_control.hide()
		"animation":
			btn_add.disabled=false
			anim_control.show()
			layer_control.hide()
			res_control.hide()
			bone_control.hide()
#复用 添加图层等
func add_res(btn_layer:Button):
	var pressed_button=btn_layer.group.get_pressed_button().name
	match pressed_button:
		"layer":
			pass
		"resource":
			#get_tree().current_scene.get_node("CanvasLayer2/FileDialog").popup()			
			pass
		"bone":
			pass
		"animation":
			get_tree().current_scene.get_node("CanvasLayer2/ask_add_anim").show()
			pass
	pass
#添加图片资源 用于绑定
func add_resource(res_rect:TextureRect):
	var json={"name":res_rect.name,"texture":res_rect.texture}
	var res_textures_data=to_json(json)
	res_textures.append(res_textures_data)
	#get_tree().current_scene.add_child(res_rect)
	pass
#重命名按钮
func rename_btn(in_name:String):
	print_debug(current_select)
	current_select.text=in_name
	pass
#不知道干嘛用的代码
func remove_resource(node:Control,res_rect:TextureRect,area:Area2D):
	print("删除资源!")
	node.queue_free()
	res_rect.queue_free()
	area.queue_free()
