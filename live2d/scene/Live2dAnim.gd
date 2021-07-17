extends Node2D
onready var animPlayer=$AnimationPlayer
signal sync_anim_add
#添加动画
func _on_ask_new_anim_add_anim(animName):
	var animation=Animation.new()
	animation.resource_name=animName
	emit_signal("sync_anim_add",animName)
	
