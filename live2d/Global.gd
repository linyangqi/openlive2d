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
#加载外部图片
func load_external_image(filepath:String):
	var f=File.new()
	f.open(filepath,File.READ)
	var buffer=f.get_buffer(f.get_len())
	var image=Image.new()
	var texture=ImageTexture.new()
	if filepath.ends_with("jpg"):
		image.load_jpg_from_buffer(buffer)
	if filepath.ends_with("png"):
		image.load_png_from_buffer(buffer)
	if filepath.ends_with("tga"):
		image.load_tga_from_buffer(buffer)
	if filepath.ends_with("webp"):
		image.load_webp_from_buffer(buffer)
	if filepath.ends_with("bmp"):
		image.load_jpg_from_buffer(buffer)
	else:
		print_debug("错误，不支持的文件类型")
	texture.create_from_image(image)
	f.close()
	return texture
