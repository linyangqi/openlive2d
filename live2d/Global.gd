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
#拖动代码
var drag=load("res://live2d/class/drag.gd").new()
#编辑器数据类
var editor_data:LiveEditorData=load("res://live2d/class/editor_data/EditorData.gd").new()
var editor_data_mode:LiveEditMode=load("res://live2d/class/editor_data/LiveEditMode.gd").new()
func bind_btn_font(button:Array,custom_font):
	for i in button:
		i.set("custom_fonts/font",custom_font)
func adder(node:Node,child_array:Array):
	for i in child_array:
		node.add_child(i)
