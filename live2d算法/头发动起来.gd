extends Node2D
var point=load("res://live2d算法/point.tscn")
var points=[]
var index=0
var mouse_start_pos
var mouse_move_speed=2
func initMenuBar():
	$CanvasLayer/MenuBar/language.add_item("Chinese")
	$CanvasLayer/MenuBar/language.add_item("English")
	$CanvasLayer/MenuBar/language.add_item("Japanese")
	$CanvasLayer/MenuBar/language.text="language"
	#
func _ready():
	initMenuBar()
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
			#print_debug(event.position)
			pass
		if event.button_index==BUTTON_RIGHT:
			mouse_start_pos=event.position
			print("视图移动",event.position)
			pass
		if event.button_index==BUTTON_WHEEL_UP:
			$Camera2D.zoom.x-=0.1
			$Camera2D.zoom.y-=0.1
			print("zoom",$Camera2D.zoom)
			$CanvasLayer/MenuBar/zoom.text="zoom:"+str($Camera2D.zoom.x)
		if event.button_index==BUTTON_WHEEL_DOWN:
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
	$FileDialog.popup()
	pass # Replace with function body.
func _on_savefile_pressed():
	$FileDialog.popup()
	$FileDialog.mode=FileDialog.MODE_SAVE_FILE
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
	$about.popup()
	pass # Replace with function body.


func _on_openlive2d_pressed():
	OS.shell_open("https://gitee.com/open-live2d/OpenLive2d")
	pass # Replace with function body.


func _on_editor_pressed():
	OS.shell_open("https://gitee.com/small-sandbox/Godot_useful_codes")
	pass # Replace with function body.
