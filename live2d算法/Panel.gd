extends Panel

func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ske_pressed():
	$ske_tree.show()
	pass # Replace with function body.


func _on_animation_pressed():
	$ske_tree.hide()
	pass # Replace with function body.
	
#右键菜单
# warning-ignore:unused_argument
func _on_ske_tree_item_rmb_selected(position):
	print("右键")
	print(position)
	$PopupMenu.popup()
	pass # Replace with function body.


func _on_ske_tree_cell_selected():
	print("cell select")
	pass # Replace with function body.


func _on_ske_tree_item_rmb_edited():
	pass # Replace with function body.


func _on_PopupMenu_id_pressed(id):
	if id==0:
		print_debug("删除")
	if id==1:
		print_debug("删除所有(除root以外骨骼)")
	pass # Replace with function body.
