extends CanvasLayer

func _ready():
	pass

func _on_button_pressed():
	Fade.fade("res://scenes/map/map.tscn")

func game_over():
	self.show()
	$Control/Leaderboard.initialize()
	#var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	#print("Scores: " + str(sw_result.scores))
