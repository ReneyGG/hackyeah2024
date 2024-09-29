extends Control

var slide = 0

func _ready():
	$AnimatedSprite2D.frame = 0

func _on_texture_button_pressed():
	Audio.get_node("Icon").play()
	slide += 1
	if slide == 1:
		$AnimatedSprite2D.frame = 1
	elif slide == 2:
		$AnimatedSprite2D.frame = 2
	elif slide == 3:
		Fade.fade("res://scenes/mainmenu/main_menu.tscn")
