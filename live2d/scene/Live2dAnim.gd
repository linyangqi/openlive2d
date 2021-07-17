extends Node2D
onready var animPlayer=$AnimationPlayer
signal sync_anim_add
var mode=""
#同步建模编辑器的数据
func sync_data_fromModel_editor():

	pass
func test():
	
	pass
func _process(delta):
	if mode=="rotate":
		$Sprite.look_at(get_global_mouse_position())
func _input(event):
	if event.is_action_pressed("rotate"):
		mode="rotate"
	if event is InputEventMouseButton:
		mode=""
#添加动画
func _on_ask_new_anim_add_anim(animName):
	var animation=Animation.new()
	animation.resource_name=animName
	emit_signal("sync_anim_add",animName)
	
