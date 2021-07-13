extends CanvasLayer

func _ready():
	pass 
#取消新建图层
func _on_cancel_pressed():
	$ask_layer.hide()
	pass 
#切换到图层功能
func _on_layer_pressed():
	print("切换到图层")
	$Panel/res_content.hide()
	pass # Replace with function body.
#添加图层
func _on_ok_pressed():
	var button=Button.new()
	var btn_img=Button.new()
	button.toggle_mode=true
	button.text="显示"
	button.icon=Global.icon_show
	button.connect("toggled",self,"show_hide",[button])
	btn_img.text=$ask_layer/editbox.text
	var btn_bind=Button.new()
	btn_bind.text="绑定图片"
	bind_btn_font([button,btn_img,btn_bind],Global.font)
	btn_bind.connect("pressed",self,"show_bind_texture")
	$Panel/layer/pre_imgRoot.add_child(button)
	$Panel/layer/pre_imgRoot.add_child(btn_img)
	$Panel/layer/pre_imgRoot.add_child(btn_bind)
	pass
#计划在Global重构
func bind_btn_font(button:Array,font):
	for i in button:
		i.set("custom_fonts/font",font)
func show_bind_texture():
	$ask_bind.show()
	pass
func show_hide(button_pressed,button:Button):
	if button_pressed:
		button.text="隐藏"
		button.icon=Global.icon_hide
	else:
		button.text="显示"
		button.icon=Global.icon_show
	pass


func _on_bind_cancel_pressed():
	$ask_bind.hide()
	pass # Replace with function body.
