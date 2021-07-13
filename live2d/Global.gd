extends Node
var font=load("res://live2d/font.tres")
var icon_show=load("res://live2d/img/eye_open.png")
var icon_hide=load("res://live2d/img/eye_close.png")
var res_manager=load("res://live2d/class/ResourceManager.gd").new()
var anim_data=load("res://live2d/class/AnimData.gd").new()

var style_button_pressed=load("res://live2d/tres/button_pressed.tres")
var style_item_select=load("res://live2d/tres/item_select.tres")
#当前动画数据
var current_anim_data
#左侧 动画帧编辑器单利
var animFrameWindow=load("res://live2d/class/AnimFrameWindow.gd").new()
func _ready():
	pass
func bind_btn_font(button:Array,custom_font):
	for i in button:
		i.set("custom_fonts/font",custom_font)
func adder(node:Node,child_array:Array):
	for i in child_array:
		node.add_child(i)
