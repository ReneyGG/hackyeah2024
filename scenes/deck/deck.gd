extends CanvasLayer

@onready var texture = $Control/TextureRect

var card = 0

@export var descs = {
	1:"Get more food",
	2:"Fire resistance",
	3:"Get more population",
	4:"Lose less food",
	5:"Lose less population",
	6:"Gain more points for each negative effect",
	7:"Survive on no food once",
}

func _ready():
	randomize()
	$Control.show()
	$Choose.hide()

func get_card():
	Audio.get_node("KartaFullscreen").play()
	$Control.show()
	$Choose.hide()
	self.show()
	card = randi_range(1,7)
	$Control/Label.text = descs[card]
	match card:
		1:
			texture.texture = load("res://assets/mniam.karta.png")
		2:
			texture.texture = load("res://assets/odpornoscprzedogniem.karta.png")
		3:
			texture.texture = load("res://assets/juhumamydziecik.karta.png")
		4:
			texture.texture = load("res://assets/najedzonydebil.karta.png")
		5:
			texture.texture = load("res://assets/dziad.karta.png")
		6:
			texture.texture = load("res://assets/coszacos.karta.png")
		7:
			texture.texture = load("res://assets/jedenruchdlazmarlych.karta.png")

func _on_skip_button_pressed():
	Audio.get_node("Icon").play()
	if get_parent().slot1 == 0:
		get_parent().slot1 = card
		get_parent().get_node("MainUI").change_card_1(texture.texture.resource_path)
		self.hide()
	elif get_parent().slot2 == 0:
		get_parent().slot2 = card
		get_parent().get_node("MainUI").change_card_2(texture.texture.resource_path)
		self.hide()
	else:
		choose()

func load_txt(n):
	match n:
		1:
			return "res://assets/mniam.karta.png"
		2:
			return "res://assets/odpornoscprzedogniem.karta.png"
		3:
			return "res://assets/juhumamydziecik.karta.png"
		4:
			return "res://assets/najedzonydebil.karta.png"
		5:
			return "res://assets/dziad.karta.png"
		6:
			return "res://assets/coszacos.karta.png"
		7:
			return "res://assets/jedenruchdlazmarlych.karta.png"

func choose():
	$Choose/TextureButton.texture_normal = load(load_txt(get_parent().slot1))
	$Choose/TextureButton2.texture_normal = load(load_txt(get_parent().slot2))
	$Control.hide()
	$Choose.show()

func _on_texture_button_pressed():
	Audio.get_node("Icon").play()
	get_parent().slot1 = card
	get_parent().get_node("MainUI").change_card_1(load_txt(get_parent().slot1))
	self.hide()

func _on_texture_button_2_pressed():
	Audio.get_node("Icon").play()
	get_parent().slot2 = card
	get_parent().get_node("MainUI").change_card_2(load_txt(get_parent().slot2))
	self.hide()
