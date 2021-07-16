extends Node2D
func _ready():
	var animation=Animation.new()
	animation.resource_name="test"
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, "TextureRect:rect_rotation")
	animation.track_insert_key(track_index, 0.0, 0)
	animation.track_insert_key(track_index, 1, 100)
	animation.length=1
	animation.loop=true
	$AnimationPlayer.add_animation("测试",animation)
	$AnimationPlayer.play("测试")
