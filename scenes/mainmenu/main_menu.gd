extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.get_node("MainMenu").play()

func _on_button_2_pressed():
	Audio.get_node("Icon").play()
	Fade.fade("res://addons/silent_wolf/Scores/LeaderboardSHOW.tscn")

func _on_play_button_pressed():
	Audio.get_node("MainMenu").stop()
	Audio.get_node("Icon").play()
	Fade.fade("res://scenes/map/map.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
