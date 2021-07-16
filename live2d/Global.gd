extends Node
#编辑器资源
var font=load("res://live2d/font.tres")
var icon_show=load("res://live2d/img/eye_open.png")
var icon_hide=load("res://live2d/img/eye_close.png")
var icon_select=load("res://live2d/img/arrow.png")
#var anim_data=load("res://live2d/class/AnimData.gd").new()
var style_button_pressed=load("res://live2d/tres/button_pressed.tres")
var style_item_select=load("res://live2d/tres/item_select.tres")
#当前动画数据
var current_anim_data
#拖动代码
var drag=load("res://live2d/class/drag.gd").new()
#编辑器数据类
var editor_data=load("res://live2d/class/editor_data/EditorData.gd").new()
var editor_mode=load("res://live2d/class/editor_data/LiveEditMode.gd").new()
func _ready():
	print_debug("全局变量初始化！")
	print("编辑器数据对象>",editor_data)
	print("编辑器模式对象>",editor_mode)
	print("编辑器资源管理器对象>",ResourceManager)
func bind_btn_font(button:Array,custom_font):
	for i in button:
		i.set("custom_fonts/font",custom_font)
func adder(node:Node,child_array:Array):
	for i in child_array:
		node.add_child(i)
#加载外部文件
func load_external_image(filepath:String):
	
	pass
