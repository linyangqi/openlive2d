class_name editorTrackBox
extends HBoxContainer
var track_vbox=VBoxContainer.new()


func draw_time_line():
	
	pass
func get_drag_data(position):
	print(position)
func draw_bg():
	
	pass
func draw_key():
	
	pass
func _draw():
	draw_rect(Rect2(0,0,100,100),Color.black,true,1.0)
	draw_circle(Vector2(0,0),5.0,Color.white)
	#draw_line()
	pass
