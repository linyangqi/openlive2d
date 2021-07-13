extends Node
var font=load("res://live2d/font.tres")
var icon_show=load("res://live2d/img/eye_open.png")
var icon_hide=load("res://live2d/img/eye_close.png")
func bind_btn_font(button:Array,custom_font):
	for i in button:
		i.set("custom_fonts/font",custom_font)
