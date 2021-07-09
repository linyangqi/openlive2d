extends ColorRect
signal pos(pos)
export var speed=5
func _ready():
	pass
func _process(delta):
	if Input.is_action_pressed("w"):
		self.rect_position.y-=speed
	if Input.is_action_pressed("s"):
		self.rect_position.y+=speed
	if Input.is_action_pressed("d"):
		self.rect_position.x+=speed
	if Input.is_action_pressed("a"):
		self.rect_position.x-=speed
	emit_signal("pos",self.rect_position)
	pass
