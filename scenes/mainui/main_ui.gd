extends CanvasLayer

@onready var animation = $AnimationPlayer

@export var food := 0
@export var population := 0
@export var points := 0

func _ready():
	food = 5
	population = 1
	points = 0
	update_food()
	update_population()
	update_points()

func update_food():
	$Control/Food.text = "Food: "+str(food)
	animation.play("food")

func update_population():
	$Control/Population.text = "Population "+str(population)
	animation.play("population")

func update_points():
	$Control/Points.text = "Points "+str(points)
	animation.play("points")
