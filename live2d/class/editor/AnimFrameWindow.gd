extends Node
#view类
#当前选中的一行动画帧 ui
var current_item:Panel
var rotation_label:Label
var root:Node
var btn_cancel:Button
var panel_ask_anim:Panel
#询问根节点
var node_asks:CanvasLayer
#左侧动画帧编辑器 参数:animFrameLayer节点 asks节点
func init_gui(node_root,in_node_asks:CanvasLayer):
	root=node_root
	node_asks=in_node_asks
	print("初始化动画帧编辑器窗口>",self)
	print("初始化动画帧编辑器root>",root.name)
	btn_cancel=in_node_asks.find_node("cancel")
	panel_ask_anim=in_node_asks.get_node("ask_add_anim")
	init_connect()
func show_add_panel():
	$CanvasLayer2/ask_add_anim.show()
	$CanvasLayer2/ask_add_anim/anim_name/add_anim.disabled=true
	$CanvasLayer2/ask_add_anim/anim_name/add_frame.disabled=false
func init_connect():
	var btn_addAnimFrame=root.get_node("anim_split/anim_frame_panel/vbox/HBoxContainer/add")
	var btn_cancel_add=panel_ask_anim.find_node("cancel")
	var btn_remove_frame=root.find_node("remove")
	var btn_hide_window=root.find_node("hide")
	btn_addAnimFrame.connect("pressed",self,"show_ask_panel")
	btn_cancel_add.connect("pressed",self,"hide_ask_panel")
	btn_remove_frame.connect("pressed",self,"frame_remove")
	btn_hide_window.connect("pressed",self,"hide_window")
func show_ask_panel():
	panel_ask_anim.show()
	panel_ask_anim.find_node("add_frame").disabled=false
	panel_ask_anim.find_node("add_anim").disabled=true
func hide_ask_panel():
	panel_ask_anim.hide()
func hide_window():
	root.get_child(0).hide()
func add_frame(rotation,current_node:Node2D,time):
	var line_panel=Panel.new()
	line_panel.rect_min_size=Vector2(200,32)
	root.find_node("anim_vbox").add_child(line_panel)
	var frame_name=panel_ask_anim.get_node("anim_name").text
	#时间补间 延迟ms
	var label_time=Label.new()
	label_time.text="时间:"+str(time)
	var preline=HBoxContainer.new()
	var label_rotation=label_time.duplicate()
	label_rotation.text="旋转角度:"+str(rotation)
	line_panel.add_child(preline)
	preline.add_child(label_time)
	preline.add_child(label_rotation)
	Global.bind_btn_font([label_time,label_rotation],Global.font)
	AnimData.set_property("rotation_degrees")
	AnimData.reg_key(rotation,current_node)
	#选中信息
	preline.connect("gui_input",self,"frame_selected",[line_panel])
func frame_selected(event,preline:Panel):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index==BUTTON_LEFT:
			print("选中帧")
			preline.set("custom_styles/panel",load("res://live2d/tres/panel.tres"))
			current_item=preline
func frame_remove():
	if is_instance_valid(current_item):
		current_item.queue_free()
	else:
		OS.alert("错误，没有要删除的对象")
func update_rotation(rotation):
	if rotation_label!=null:
		rotation_label.text="旋转角度:"+str(rotation)
