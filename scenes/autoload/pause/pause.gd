extends CanvasLayer

var on := false
var b_flag := false
var av := true

#func _ready():
	#$Control.hide()
	#$Control/Tutorial.hide()

#func _input(event):
	#if Input.is_action_just_pressed("pause") and not get_tree().current_scene.name == "Main" and av:
		#if get_tree().paused:
			#unpause()
		#else:
			#pause()

func pause():
	b_flag = false
	on = true
	get_tree().paused = true
	$Control.show()

func unpause():
	on = false
	get_tree().paused = false
	$Control.hide()
	$Control/Tutorial.hide()

func _on_back_button_pressed():
	unpause()

func _on_tut_button_pressed():
	$Control/Tutorial.show()

func _on_menu_button_pressed():
	if not b_flag:
		b_flag = true
		Fade.fade("res://scenes/menu/menu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_exit_tutorial_pressed():
	$Control/Tutorial.hide()
