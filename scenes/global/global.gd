extends Node

var points

func _ready():
	SilentWolf.configure({
	"api_key": "wMhmUFOCP5687UcCprCAu2uJp6uzQtQo1M3uaKm4",
	"game_id": "biocorpbreaker",
	"log_level": 1
	})
	
	#SilentWolf.Scores.wipe_leaderboard()
	
	points = 0
