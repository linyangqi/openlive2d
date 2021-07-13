extends Object
var current_item:Panel
var rotation_label:Label
func frame_selected(node:Panel,frame_name:String):
	#print(node)
	print("选中动画帧>名称:"+frame_name)
	node.set("custom_styles/panel",Global.style_item_select)
	current_item=node
	rotation_label=node.get_child(0).get_child(2)
	print_debug("旋转label",rotation_label)
func frame_remove():
	current_item.queue_free()
func update_rotation(rotation):
	rotation_label.text="旋转角度:"+str(rotation)
