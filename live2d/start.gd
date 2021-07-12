extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2.0),"timeout")
	var editor=load("res://live2d/scene/Live2dEditor.tscn")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(editor)
	pass # Replace with function body.
# warning-ignore:unused_argument
func _process(delta):

	pass
