extends Node
var root:Panel
var box:VBoxContainer
func init_gui(node):
	root=node
	box=root.get_node("box_root")
	print("初始化物体属性面板>",self)
	init_connect()
	pass
func init_connect():
	root.find_node("hide_shu_xing").connect("pressed",self,"hide")
	pass
func add():
	pass
func remove():
	
	pass
func update_info(type):
	if type=="rotation":
		pass
	if type=="position":
		pass
	pass
func hide():
	print("隐藏")
	root.hide()
func show(node:Node2D):
	node.show()
