extends TextureButton

var focus := false
@export var side := 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	if focus:
		rotation_degrees += 1 * delta * side

func _on_mouse_entered():
	Audio.get_node("Hover").play()
	self.scale.x = lerp(self.scale.x, 1.05, 1.0)
	self.scale.y = lerp(self.scale.y, 1.05, 1.0)
	focus = true

func _on_mouse_exited():
	self.scale.x = lerp(self.scale.x, 1.0, 1.0)
	self.scale.y = lerp(self.scale.y, 1.0, 1.0)
	focus = false
	rotation_degrees = 0
