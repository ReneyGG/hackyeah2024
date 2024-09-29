extends CanvasLayer

func _ready():
	$Control.modulate = Color(1.0,1.0,1.0,0.0)

func leaderboard():
	Fade.fade("res://addons/silent_wolf/Scores/Leaderboard.tscn")

func game_over():
	Audio.get_node("Warning").play()
	self.show()
	$AnimationPlayer.play("init")
	#$Control/Leaderboard.initialize()
	
	#var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	#print("Scores: " + str(sw_result.scores))
