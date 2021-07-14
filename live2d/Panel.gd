extends PanelContainer
var skeleton_tree:Control
var res_content
var layer_scroll
var animes
var layer
func _ready():
	skeleton_tree=get_node("vbox/p/ske_tree")
	res_content=get_node("vbox/p/res_content")
	layer_scroll=get_node("vbox/p/layer_scroll")
	animes=get_node("vbox/p/animes")
	layer=get_node("vbox/p/layer_scroll")
func _on_ske_pressed():
	skeleton_tree.show()
	res_content.hide()

func _on_animation_pressed():
	skeleton_tree.hide()
	animes.show()

func _on_ske_tree_cell_selected():
	print("cell select")
func _on_ske_tree_item_rmb_edited():
	pass
func _on_PopupMenu_id_pressed(id):
	if id==0:
		print_debug("删除")
	if id==1:
		print_debug("删除所有(除root以外骨骼)")
func _on_resource_pressed():
	res_content.show()
	skeleton_tree.hide()
	layer_scroll.hide()
	animes.hide()
func _on_layer_pressed():
	print("切换到图层")
	layer_scroll.show()
	pass # Replace with function body.
