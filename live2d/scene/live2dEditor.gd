extends Node2D
var point=load("res://live2d算法/point.tscn")
var points=[]
var index=0
var mouse_start_pos
var mouse_move_speed=2
var edit_mode=""
#骨架数据
var ske_data=[]
var current_bone_index=0
var tree
var root
#文件状态类
var file_class
var FileAction
#选中的图片 按钮 骨骼 网格顶点
var selected_image:Sprite
var selected_btn:Button
var selected_bone:Node2D
var selected_mesh_point
#当前选中的物体
var current_select
var is_drag=false
func initMenuBar():
	$CanvasLayer/MenuBar/language.add_item("Chinese")
	$CanvasLayer/MenuBar/language.add_item("English")
	$CanvasLayer/MenuBar/language.add_item("Japanese")
	$CanvasLayer/MenuBar/language.text="language"
func _ready():
	Input.set_custom_mouse_cursor(load("res://live2d算法/img/arrow.png"))
	tree = $CanvasLayer/Panel/ske_tree
	root = tree.create_item()
	root.set_text(0,"skeleton")
	initMenuBar()
func init_file_class():
	#var file_res=load("res://live2d算法/class/FileDialog.gd")
	#file_class=file_res.new()
	#print(file_class)
	pass
func init_ske_tree():
	pass
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("w"):
		$Camera2D.position.y-=mouse_move_speed
	if Input.is_action_pressed("a"):
		$Camera2D.position.x-=mouse_move_speed
	if Input.is_action_pressed("d"):
		$Camera2D.position.x+=mouse_move_speed
	if Input.is_action_pressed("s"):
		$Camera2D.position.y+=mouse_move_speed
	var fps=Engine.get_frames_per_second()
	$CanvasLayer/fps.text="fps:"+str(fps)
	pass
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index==BUTTON_LEFT:
			if edit_mode=="添加骨架":
				var bone=load("res://live2d/组件/骨骼.tscn").instance()
				add_child(bone)
				bone.position=event.position
				#print(bone)
				bone.connect("select_bone",self,"update_selected_bone",[bone])
				#同步创建gui信息
				var child1 = tree.create_item(root)
				child1.set_text(0,"bone"+str(current_bone_index))
				print(event.position)
				current_bone_index+=1
			pass
		if event.button_index==BUTTON_RIGHT:
			mouse_start_pos=event.position
			#print("视图移动",event.position)
			pass
		if event.button_index==BUTTON_WHEEL_UP and edit_mode!="导入图片" and edit_mode!="打开文件" and edit_mode!="保存文件":
			$Camera2D.zoom.x-=0.1
			$Camera2D.zoom.y-=0.1
			print("zoom",$Camera2D.zoom)
			$CanvasLayer/MenuBar/zoom.text="zoom:"+str($Camera2D.zoom.x)
		if event.button_index==BUTTON_WHEEL_DOWN and edit_mode!="导入图片" and edit_mode!="打开文件" and edit_mode!="保存文件":
			print("zoom",$Camera2D.zoom)
			$CanvasLayer/MenuBar/zoom.text="zoom:"+str($Camera2D.zoom.x)
			$Camera2D.zoom.x+=0.1
			$Camera2D.zoom.y+=0.1
		pass
func _on_reset_zoom_pressed():
	$CanvasLayer/MenuBar/zoom.text="zoom:"+str(1)
	$Camera2D.zoom=Vector2(1,1)
	pass # Replace with function body.


func _on_add_point_pressed():
	index+=1
	var point_instance=point.instance()
	point_instance.name="point"+str(index)
	point_instance.position=$Position2D.position
	points.append(point)
	
	add_child(point_instance)
	
	pass # Replace with function body.


func _on_File_pressed():
	var popup=$File.get_popup()
	print(popup.get_current_index())
#	var text=popup.get_item_text(popup.get_current_index())
#	print(text)
	#$FileDialog.popup()
	pass # Replace with function body.


func _on_File_about_to_show():
	print("about to show")
	pass # Replace with function body.


func _on_openfile_pressed():
	update_mode_tip("打开文件")
	$CanvasLayer2/FileDialog.popup()
	pass # Replace with function body.
func _on_savefile_pressed():
	$CanvasLayer2/FileDialog.popup()
	$CanvasLayer2/FileDialog.mode=FileDialog.MODE_SAVE_FILE
	update_mode_tip("保存文件")
	pass # Replace with function body.

#添加动画id名称
func _on_add_pressed():
	$CanvasLayer2/anim_name.show()
	pass # Replace with function body.

#添加动画名称
func _on_ok_pressed():
	var anim_name=$CanvasLayer2/anim_name.text
	var label=Button.new()
	label.text=anim_name
	label.connect("pressed",self,"edit_selected_anim",[anim_name])
	var rename_btn=Button.new()
	rename_btn.text="rename"
	var remove_btn=Button.new()
	remove_btn.text="-remove"
	remove_btn.connect("pressed",self,"remove_anim")
	
	$CanvasLayer/Panel/animes/item.add_child(label)
	$CanvasLayer/Panel/animes/item.add_child(rename_btn)
	$CanvasLayer/Panel/animes/item.add_child(remove_btn)
	$CanvasLayer2/anim_name.hide()
	
	pass # Replace with function body.
func edit_selected_anim(anim_name):
	print_debug("!edit anim:",anim_name)
	$CanvasLayer/anim_frame_panel.show()
	pass
func remove_anim():
#	todo
	print("删除动画")
	pass
	pass
#关闭对话
func _on_cancel_pressed():
	$CanvasLayer2/anim_name.hide()
	pass # Replace with function body.


func _on_anim_frame_add_pressed():
	$CanvasLayer2/anim_name.show()
	pass # Replace with function body.

#添加动画帧
func _on_add_frame_pressed():
	var frame_name=$CanvasLayer2/anim_name.text
	var label=Button.new()
	label.text=frame_name
	#时间补间 延迟ms
	var label_time=Label.new()
	label_time.text="time bu jian时间补间0ms"
	$CanvasLayer/anim_frame_panel/animes.add_child(label)
	$CanvasLayer/anim_frame_panel/animes.add_child(label_time)
	$CanvasLayer2/anim_name.hide()
	pass # Replace with function body.
func _on_about_pressed():
	$CanvasLayer2/about.popup()
	pass # Replace with function body.


func _on_openlive2d_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://gitee.com/open-live2d/OpenLive2d")
	pass # Replace with function body.


func _on_editor_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://gitee.com/small-sandbox/Godot_useful_codes")
	pass # Replace with function body.


func _on_add_ske_pressed():
	update_mode_tip("添加骨架")
	$CanvasLayer/MenuBar/control_tip.text="操作提示："+"按下鼠标来添加骨骼"
	pass # Replace with function body.
#播放动画按钮
func _on_play_pressed():
	update_mode_tip("播放动画")
	edit_mode="play anim"
	pass # Replace with function body.

#导入图片资源
func _on_import_img_pressed():
	update_file_state("导入图片")
	update_mode_tip("导入图片")
	$CanvasLayer2/FileDialog.mode=FileDialog.MODE_OPEN_ANY
	$CanvasLayer2/FileDialog.popup()
#更新文件状态
func update_file_state(action):
	FileAction=action
	#file_class.FileAction=action
	pass
#更新toolbar模式提示
func update_mode_tip(text:String):
	$CanvasLayer/MenuBar/edit_mode.text="当前模式:"+text
	edit_mode=text
	print("模式:"+text)
func update_selected_bone(bone:Node2D):
	selected_bone=bone
	print_debug("同步信息：选中的骨骼",bone)
	$CanvasLayer2/selected_bone.text="选中的骨骼："+bone.name
#加载外部文件
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
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func drag(viewport, event, shape_idx):
	print(event)
	pass
func _on_FileDialog_file_selected(path):
	if FileAction=="导入图片":
		print_debug(path)
		var texture=load_external_image(path)
		var area=Area2D.new()
		var col2d=CollisionShape2D.new()
		var shape=RectangleShape2D.new()
		shape.extents=Vector2(200,200)
		col2d.shape=shape
		area.connect("input_event",self,"drag")
		var sprite=Sprite.new()
		sprite.texture=texture
		area.name=path.get_basename()
		add_child(area)
		#area.add_child(sprite)
		area.position=$Position2D.position
		#更新gui
		var button=Button.new()
		button.text=path.get_file()
		button.set("custom_fonts/font",load("res://live2d/tres/font.tres"))
	
		button.connect("pressed",self,"select_image",[sprite.name,button])
		$CanvasLayer/Panel/res_content/res_layer.add_child(button)
	pass
#sprite button
func select_image(image_name:String,button:Button):
	selected_image=get_node(image_name)
	selected_btn=button
	#同步当前选中的物体
	current_select=selected_image
	button.set("custom_styles/normal",load("res://live2d/tres/button_pressed.tres"))
	print_debug("删除对象：",selected_image)
#取消文件选择
func _on_FileDialog_popup_hide():
	print("取消文件选择")
	update_mode_tip("预览")
#资源管理删除按钮 弹出确认窗口
func _on_del_pressed():
	print("要删除的对象",selected_image)
	#如果有任意选中的对象
	if selected_image!=null or selected_btn!=null or selected_bone!=null:
		$CanvasLayer2/confirmDel.popup()
	else:
		OS.alert("错误，没有选中要删除的对象")
	pass 
#确认删除
func _on_confirmDel_confirmed():
	if selected_bone!=null:
		selected_bone.queue_free()
	if selected_image!=null:
		selected_image.queue_free()
	if selected_btn!=null:
		selected_btn.queue_free()
	pass 


func _on_rotate_tool_pressed():
	Input.set_custom_mouse_cursor(load("res://live2d/img/旋转2.png"))
	update_mode_tip("旋转模式")
	pass # Replace with function body.


func _on_move_tool_pressed():
	Input.set_custom_mouse_cursor(load("res://live2d/img/arrow.png"))
	update_mode_tip("选择模式")
	pass # Replace with function body.
