extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_pressed():
	Fade.fade("res://scenes/map/map.tscn")
