extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2.0),"timeout")
	var editor=load("res://live2d算法/scene/Live2dEditor.tscn")
	get_tree().change_scene_to(editor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
