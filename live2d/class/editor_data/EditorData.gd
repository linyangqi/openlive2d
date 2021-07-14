class_name LiveEditorData
var work_mode:String
var work_mode_model="model"
var work_mode_anim="anim"
var point_count=0
var bone_count=0
var line2d:Line2D
func new_line():
	var line2d=Line2D.new()
	return line2d
func add_line(line,x,y):
	line.add_point(Vector2(x,y))
func add_to_scene(node:Node2D,line):
	node.add_child(line)
