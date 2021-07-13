extends PanelContainer

func _ready():
	pass 
func _on_ske_pressed():
	$ske_tree.show()
	$res_content.hide()
	pass # Replace with function body.


func _on_animation_pressed():
	$ske_tree.hide()
	$animes.show()
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


func _on_resource_pressed():
	$res_content.show()
	$ske_tree.hide()
	$layer_scroll.hide()
	$animes.hide()
	pass # Replace with function body.
