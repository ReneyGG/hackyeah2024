extends CanvasLayer

@onready var animation = $AnimationPlayer

@export var food := 0
@export var population := 0
@export var points := 0

func _ready():
	$Control/ColorRect.modulate.a = 0.0
	food = 20
	population = 1
	points = 0
	update_food()
	update_population()
	update_points()

func update_food():
	Audio.get_node("Pickup").play()
	$Control/Panel/Food.text = "Food: "+str(food)
	animation.play("food")

func update_population():
	Audio.get_node("Pickup").play()
	$Control/Panel/Population.text = "Population "+str(population)
	animation.play("population")

func update_points():
	Audio.get_node("Pickup").play()
	$Control/Panel/Points.text = "Points "+str(points)
	animation.play("points")

func change_card_1(texture):
	$Control/Card1.texture = load(texture)

func change_card_2(texture):
	$Control/Card2.texture = load(texture)

func _on_card_1_mouse_entered():
	Audio.get_node("SlideCard").play()
	if not $Control/Card1.texture:
		return
	#$Hover.play()
	var tween = get_tree().create_tween()
	tween.tween_property($Control/Card1, "position", Vector2(6,200),0.1).set_trans(Tween.TRANS_QUAD)
	
	$Control/ColorRect/Label.text = get_parent().get_node("Deck").descs[get_parent().slot1]
	var tweent = get_tree().create_tween()
	tweent.tween_property($Control/ColorRect, "modulate:a", 0.74, 0.1).set_trans(Tween.TRANS_QUAD)

func _on_card_1_mouse_exited():
	Audio.get_node("SoudeCard").play()
	var tween = get_tree().create_tween()
	tween.tween_property($Control/Card1, "position", Vector2(6,277),0.1).set_trans(Tween.TRANS_QUAD)
	
	var tweent = get_tree().create_tween()
	tweent.tween_property($Control/ColorRect, "modulate:a", 0.0, 0.1).set_trans(Tween.TRANS_QUAD)


func _on_card_2_mouse_entered():
	Audio.get_node("SlideCard").play()
	if not $Control/Card2.texture:
		return
	#$Hover.play()
	var tween = get_tree().create_tween()
	tween.tween_property($Control/Card2, "position", Vector2(143,200),0.1).set_trans(Tween.TRANS_QUAD)
	
	$Control/ColorRect/Label.text = get_parent().get_node("Deck").descs[get_parent().slot2]
	var tweent = get_tree().create_tween()
	tweent.tween_property($Control/ColorRect, "modulate:a", 0.74, 0.1).set_trans(Tween.TRANS_QUAD)

func _on_card_2_mouse_exited():
	Audio.get_node("SoudeCard").play()
	var tween = get_tree().create_tween()
	tween.tween_property($Control/Card2, "position", Vector2(143,277),0.1).set_trans(Tween.TRANS_QUAD)
	
	var tweent = get_tree().create_tween()
	tweent.tween_property($Control/ColorRect, "modulate:a", 0.0, 0.1).set_trans(Tween.TRANS_QUAD)

