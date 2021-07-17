extends CanvasLayer

func _on_anim_pressed():
	Global.editor_data.work_mode=Global.editor_data.work_mode_anim
	print("切换到动画工作区")
	get_tree().change_scene("res://live2d/scene/Live2dAnim.tscn")
func _on_model_pressed():
	Global.editor_data.work_mode=Global.editor_data.work_mode_model
	print("切换到建模工作区")
