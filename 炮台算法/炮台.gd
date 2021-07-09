extends Node2D

func _process(delta):
	pass


func _on__pos(pos):
	if pos.x<self.position.x:
		self.scale.x=1
	if pos.x>self.position.x:
		self.scale.x=-1
	pass # Replace with function body.
