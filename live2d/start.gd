extends Node2D
func _ready():
	#启用透明背景
	#get_tree().root.set_transparent_background(true)
	OS.window_borderless=true
	yield(get_tree().create_timer(2.0),"timeout")
	var editor=load("res://live2d/scene/Live2dEditor.tscn")
	get_tree().change_scene_to(editor)
	#$FileDialog.popup()
