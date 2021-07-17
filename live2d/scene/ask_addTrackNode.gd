extends PopupPanel
func _on_cancel_pressed():
	hide()
func _on_ItemList_item_selected(index):
	print(index)
	var select_node_name=$vbox/ItemList.get_item_text(index)
	print("选中了节点>",select_node_name)
	if select_node_name=="测试":
		#添加轨道
		pass
