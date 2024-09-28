extends CanvasLayer

var next

func _ready():
	pass # Replace with function body.

func fade(scene):
	next = scene
	$AnimationPlayer.play("fade_out")

func change():
	Pause.unpause()
	get_tree().paused = false
	get_tree().change_scene_to_file(next)
