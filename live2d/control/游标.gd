extends Node2D


func _on_reset_cursor_pressed():
	self.position=get_tree().current_scene.get_node("Position2D").position
