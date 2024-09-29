extends CanvasLayer

var on := false
var b_flag := false
var av := true

func _ready():
	$Control.hide()

func _input(event):
	if Input.is_action_just_pressed("pause") and not get_tree().current_scene.name == "MainMenu" and av:
		if get_tree().paused:
			unpause()
		else:
			pause()

func pause():
	b_flag = false
	on = true
	get_tree().paused = true
	$Control.show()

func unpause():
	on = false
	get_tree().paused = false
	$Control.hide()

func _on_back_button_pressed():
	unpause()

func _on_menu_button_pressed():
	if not b_flag:
		b_flag = true
		Fade.fade("res://scenes/mainmenu/main_menu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
