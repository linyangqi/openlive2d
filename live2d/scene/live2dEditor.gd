#编辑器主类
extends Node2D
var point=load("res://live2d/point.tscn")
var points=[]
#骨骼数量
var bone_count=0
var mouse_start_pos
var mouse_move_speed=2
var edit_mode="预览"
#骨架数据
var ske_data=[]
var current_bone_index=0
var tree
var root
#文件状态类
var file_class
var FileAction
#选中的图片 按钮 骨骼 网格顶点
var selected_image
var selected_btn:Button
#var selected_bone
var selected_mesh_point
#当前选中的物体
var current_select
#是否可旋转
var can_rotate=false
var anim_data_gd=load("res://live2d/class/AnimData.gd")
#line2d 连线用
var line
var is_drag=false
var can_draw=false
var can_zoom=true
func _ready():
	OS.window_borderless=false
	Input.set_custom_mouse_cursor(load("res://live2d/img/arrow.png"))
	tree =$ResManagerLayer/ResManager/manager/vbox/p/ske_tree
	root = tree.create_item()
	root.set_text(0,"skeleton")
	init_window_manager()
	init_resource_manager()
func init_window_manager():
	var window=$CanvasLayer/MenuBar/window
	var popup=window.get_popup()
	popup.connect("index_pressed",self,"window_control",[popup])
#右侧gui控制 nodes[] 共有4种资源 4个面板容器
func init_resource_manager():
	ResourceManager.init_gui($ResManagerLayer)
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
	if is_drag:
		update()
	update_fps()
func _draw():
	if can_draw:
		draw_rect(Rect2(get_global_mouse_position(),Vector2(100,100)),Color.green,false,2.0,true)
func update_fps():
	var fps=Engine.get_frames_per_second()
	$CanvasLayer/fps.text="fps:"+str(fps)
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index==BUTTON_LEFT:
			if edit_mode=="添加骨架":
				can_rotate=false
				var bone=load("res://live2d/control/骨骼.tscn").instance()
				add_child(bone)
				bone.position=event.position
				Global.editor_data.bone_count+=1
				bone.name="bone"+str(Global.editor_data.bone_count)
				bone.connect("select_bone",self,"update_selected_bone",[bone])
				#同步创建gui信息
				var child1 = tree.create_item(root)
				child1.set_text(0,"bone"+str(current_bone_index))
				print(event.position)
				current_bone_index+=1
			if edit_mode=="旋转模式":
				can_rotate=true
				print("状态>",can_rotate)
			if edit_mode=="预览模式":
				#游标位置
				$CanvasLayer3/Drag.position=event.position
				can_draw=false
			if edit_mode=="添加顶点":
				Global.editor_data.point_count+=1
				var point_instance=point.instance()
				point_instance.name="point"+str(Global.editor_data.point_count)
				point_instance.position=event.position
				add_child(point_instance)
				$HudLayer/hbox/vertex_info.text="顶点信息：顶点数量>"+str(Global.editor_data.point_count)
			if edit_mode=="删除顶点":
				Global.editor_data.point_count-=1
				$HudLayer/hbox/vertex_info.text="顶点信息:顶点数量:"+str(Global.editor_data.point_count)
			if edit_mode=="顶点连线":
				line.add_point(event.position)
			if edit_mode=="框选模式":
				is_drag=true
				can_draw=true
				pass
		if event.is_pressed() and event.button_index==BUTTON_RIGHT:
			if edit_mode=="添加顶点":
				print("退出添加顶点模式")
				edit_mode="预览模式"
				sync_edit_mode(edit_mode)
				update_hud_tip("预览模式")
				update_mode_tip("预览模式")
			if edit_mode=="删除顶点":
				print("退出顶点删除模式")
				edit_mode="预览模式"
				sync_edit_mode(edit_mode)
				update_hud_tip("预览模式")
				update_mode_tip("预览模式")
			if edit_mode=="顶点连线":
				edit_mode="预览模式"
				sync_edit_mode(edit_mode)
				update_hud_tip(edit_mode)
				update_mode_tip(edit_mode)
			if edit_mode=="框选模式":
				is_drag=false
				can_draw=false
				edit_mode="预览模式"
				sync_edit_mode(edit_mode)
				update_hud_tip(edit_mode)
				update_mode_tip(edit_mode)
				print("退出框选模式")
			if edit_mode=="添加骨架":
				edit_mode="预览模式"
				update_hud_tip(edit_mode)
				update_mode_tip(edit_mode)
				sync_edit_mode(edit_mode)
		if can_zoom:
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
#添加网格顶点
func _on_add_point_pressed():
	edit_mode="添加顶点"
	update_mode_tip("添加顶点")
	update_hud_tip("左键添加顶点，右键退出编辑（完成）")
	sync_edit_mode("添加顶点")
#同步更新编辑模式到全局变量
func sync_edit_mode(value):
	Global.editor_mode.current_mode=value
#操作提示
func update_hud_tip(text):
	$HudLayer/hbox/control_tip.text="操作提示:"+text
func _on_File_pressed():
	var popup=$File.get_popup()
	print(popup.get_current_index())
	pass 
func _on_openfile_pressed():
	update_mode_tip("打开文件")
	$CanvasLayer2/FileDialog.popup()
	pass # Replace with function body.
func _on_savefile_pressed():
	$CanvasLayer2/FileDialog.popup()
	$CanvasLayer2/FileDialog.mode=FileDialog.MODE_SAVE_FILE
	update_mode_tip("保存文件")
	pass # Replace with function body.

#资源管理器的添加按钮
func _on_add_pressed():
	print("按下了添加按钮")
	var res_layer=$ResManagerLayer
	var layer=res_layer.get_node("ResManager/manager/vbox/tool_bar/layer")
	if layer.pressed:
		print("切换到图层资源面板")
		res_layer.get_node("ResManager/manager/vbox/tool_bar/layer").show()
		res_layer.get_node("ResManager/manager/vbox/layer_scroll/layer").show()
	#询问是否添加动画
	if res_layer.get_node("ResManager/manager/vbox/tool_bar/animation").pressed:
		print("切换到动画资源面板")
		$CanvasLayer2/ask_add_anim.show()
		$CanvasLayer2/ask_add_anim/anim_name/add_frame.disabled=true
		$CanvasLayer2/ask_add_anim/anim_name/add_anim.disabled=false
#添加动画名称 资源管理器 右侧
func _on_ok_pressed():
	var anim_name=$CanvasLayer2/ask_add_anim/anim_name.text
	var label=Button.new()
	label.text=anim_name
	label.connect("pressed",self,"edit_selected_anim",[anim_name])
	var rename_btn=Button.new()
	rename_btn.text="重命名"
	var remove_btn=Button.new()
	remove_btn.text="删除"
	var preline=HBoxContainer.new()
	preline.add_child(label)
	preline.add_child(rename_btn)
	preline.add_child(remove_btn)
	rename_btn.connect("pressed",self,"rename_things",[preline.get_child(0)])
	remove_btn.connect("pressed",self,"remove_anim",[remove_btn.get_parent()])
	$CanvasLayer2/ask_add_anim.hide()
	Global.bind_btn_font([label,rename_btn,remove_btn],Global.font)
	#添加动画
	print("动画数据对象>",Global.anim_data)
	$HudLayer/current_tip/edited_anim.text="当前编辑的动画:"+anim_name
	ResourceManager.add_layer(preline)
	pass 
func rename_things(rename_btn):
	Global.res_manager.current_select=rename_btn
	print("重命名!,对象",Global.res_manager.current_select)
	$CanvasLayer/ask_rename.show()
func edit_selected_anim(anim_name):
	print_debug("!edit anim:",anim_name)
	$CanvasLayer/anim_frame_panel.show()
	pass
func remove_anim(preline:Control):
	print("删除动画",preline)
	preline.queue_free()
	pass
#关闭对话
func _on_cancel_pressed():
	$CanvasLayer2/ask_add_anim.hide()
	pass 
#添加动画帧按钮 动画编辑器里的
func _on_anim_frame_add_pressed():
	$CanvasLayer2/ask_add_anim.show()
	$CanvasLayer2/ask_add_anim/anim_name/add_anim.disabled=true
	$CanvasLayer2/ask_add_anim/anim_name/add_frame.disabled=false
	pass 
#添加动画帧 左侧 动画帧编辑器
func _on_add_frame_pressed():
	var root=get_node("CanvasLayer")
	var line_panel=Panel.new()
	#line_panel.set("custom_styles/panel",Global.tres_button_pressed)
	line_panel.rect_min_size=Vector2(200,32)
	root.find_node("anim_vbox").add_child(line_panel)
	var frame_name=$CanvasLayer2/ask_add_anim/anim_name.text
	var label=Button.new()
	label.text=frame_name
	#时间补间 延迟ms
	var label_time=Label.new()
	label_time.text="时间补间0ms"
	var preline=HBoxContainer.new()
	var label_rotation=label_time.duplicate()
	label_rotation.text="旋转角度:0"
	line_panel.add_child(preline)
	preline.add_child(label)
	preline.add_child(label_time)
	preline.add_child(label_rotation)
	label.connect("pressed",Global.animFrameWindow,"frame_selected",[label.get_parent().get_parent(),label.text])
	Global.bind_btn_font([label,label_time,label_rotation],Global.font)
	$CanvasLayer2/ask_add_anim.hide()
	pass 
func _on_about_pressed():
	$CanvasLayer2/about.popup()
	pass 
func _on_openlive2d_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://gitee.com/open-live2d/OpenLive2d")
	pass 
func _on_editor_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://gitee.com/small-sandbox/Godot_useful_codes")
	pass # Replace with function body.
func _on_add_ske_pressed():
	update_mode_tip("添加骨架")
	#$.disabled=false
	$HudLayer/hbox/control_tip.text="操作提示："+"按下鼠标来添加骨骼"
	pass # Replace with function body.
#播放动画按钮
func _on_play_pressed():
	update_mode_tip("播放动画")
	edit_mode="play anim"
	AnimData.caculate_anim()
	pass # Replace with function body.
#导入图片资源
func _on_import_img_pressed():
	update_file_state("导入图片")
	update_mode_tip("导入图片")
	$CanvasLayer2/FileDialog.mode=FileDialog.MODE_OPEN_ANY
	$CanvasLayer2/FileDialog.set_filters(PoolStringArray(["*.png;*.jpg;*.bmp;*.tga;*.webp;"]))
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
#更新选中的对象提示
func update_selected_bone(bone:Node2D):
	current_select=bone
	print_debug("同步信息：选中的骨骼",bone)
	$HudLayer/current_tip/selected_bone.text="选中的对象："+bone.name
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
		#资源管理器中的图片
		var res_rect=TextureRect.new()
		res_rect.texture=texture
		res_rect.expand=true
		res_rect.rect_min_size=Vector2(32,32)
		var preline=HBoxContainer.new()
		ResourceManager.import_resource_to_manager(preline)
		area.name=path.get_basename()
		add_child(area)
		#area.add_child(sprite)
		area.position=$Position2D.position
		#图片名称按钮 
		var button=Button.new()
		button.text=path.get_file().split(".")[0]
		var btn_del=Button.new()
		btn_del.text="删除"
		button.connect("pressed",self,"select_image",[area.name,button])
		#更新gui 图层
		preline.add_child(res_rect)
		preline.add_child(button)
		preline.add_child(btn_del)
		#调用资源管理器处理
		btn_del.connect("pressed",ResourceManager,"remove_resource",[btn_del.get_parent(),res_rect,area])
		Global.bind_btn_font([button,btn_del],Global.font)
	pass
#sprite button
func select_image(image_name:String,button:Button):
	selected_image=get_node(image_name)
	selected_btn=button
	#同步当前选中的物体
	current_select=selected_image
	#button.set("custom_styles/normal",load("res://live2d/tres/button_pressed.tres"))
	print_debug("删除对象：",selected_image)
#取消文件选择
func _on_FileDialog_popup_hide():
	print("取消文件选择")
	update_mode_tip("预览")
#资源管理删除按钮 弹出确认窗口
func _on_del_pressed():
	print("要删除的对象",current_select)
	#重构删除方法
	$CanvasLayer2/confirmDel.dialog_text="要删除的对象>"+str(current_select)	
	$CanvasLayer2/confirmDel.popup()
#确认删除
func _on_confirmDel_confirmed():
	print(is_instance_valid(current_select))
	print(current_select)
	if is_instance_valid(current_select):
		current_select.queue_free()
	else:
		print("在内存中不存在这个对象")
		OS.alert("在内存中不存在选中的对象")
	pass 
func _on_rotate_tool_pressed():
	Input.set_custom_mouse_cursor(load("res://live2d/img/旋转2.png"))
	update_mode_tip("旋转模式")
func _on_move_tool_pressed():
	Input.set_custom_mouse_cursor(load("res://live2d/img/arrow.png"))
	update_mode_tip("选择模式")
func _on_ProgressBar_value_changed(value):
	$control_layer/ProgressBar/Label.text="旋转角度:"+str(value)
	if current_select!=null:
		var node=get_node(current_select.name)
		#print("选中了:",node)
		node.set("rotation_degrees",value)
func window_control(index,popup:PopupMenu):
	var check0=popup.is_item_checked(index)
	if not check0:
		popup.set_item_checked(index,true)
		if index==0:
			$CanvasLayer/anim_split.show()
		if index==1:
			$control_layer/tool_bar.show()
		if index==2:
			$ResManagerLayer/ResManager.show()
		if index==3:
			$control_layer/ScrollContainer.show()
	if check0:
		popup.set_item_checked(index,false)
		if index==0:
			$CanvasLayer/anim_split.hide()
		if index==1:
			$control_layer/tool_bar.hide()
		if index==2:
			$ResManagerLayer/ResManager.hide()
		if index==3:
			$control_layer/ScrollContainer.hide()
	print_debug("选中项状态",check0)
	pass
#绑定图层材质
func _on_bind_ok_pressed():
	var texture_name=$CanvasLayer/ask_bind/editbox.text
	print(ResourceManager.res_textures)
#重置编辑器
func _on_reset_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	pass 
func _on_window_pressed():
	pass 
func _on_rename_cancel_pressed():
	$CanvasLayer/ask_rename.hide()
	pass
#注册关键帧
func _on_reg_key_pressed():
	if current_select!=null:
		var rotation=current_select.rotation_degrees
		print("注册帧>对象:",current_select)
		print("注册帧>旋转信息:",rotation)
		AnimData.add_anim("a",rotation,current_select)
		#Global.animFrameWindow.update_rotation(rotation)
#删除顶点
func _on_del_point_pressed():
	update_hud_tip("点击要删除的顶点,右键退出")
	update_mode_tip("删除顶点模式")
	edit_mode="删除顶点"
	sync_edit_mode(edit_mode)
#顶点连线
func _on_point_toline_pressed():
	update_hud_tip("点击输入坐标，连线")
	update_mode_tip("顶点连线模式")
	edit_mode="顶点连线"
	sync_edit_mode(edit_mode)
	line=Line2D.new()
	#line.position=$Position2D.position
	$test.rect_position=$Position2D.position
	add_child(line)
	pass
#框选工具
func _on_rect_select_pressed():
	edit_mode="框选模式"
	print("进入框选模式！")
	sync_edit_mode(edit_mode)
	update_hud_tip("拖动鼠标来框选物体，右键退出")
	update_mode_tip(edit_mode)
	pass
func _on_ScrollContainer_mouse_entered():
	can_zoom=false
	print("不许缩放")
	pass
