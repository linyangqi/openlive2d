extends PanelContainer

func _ready():
	pass 
func _on_ske_pressed():
	$vbox/ske_tree.show()
	$vbox/res_content.hide()
	pass # Replace with function body.


func _on_animation_pressed():
	$vbox/ske_tree.hide()
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
	pass 
func _on_resource_pressed():
	$vbox/res_content.show()
	$vbox/ske_tree.hide()
	$vbox/layer_scroll.hide()
	$vbox/animes.hide()
	pass 
