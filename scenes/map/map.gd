extends Node2D

@onready var tilemap = $TileMap
@onready var player = $Player
@onready var ui = $MainUI

var target_player_pos

func _ready():
	player.global_position = tilemap.map_to_local(Vector2(2,1))
	target_player_pos = player.global_position

func _physics_process(_delta):
	player.scale.x = lerp(player.scale.x, 1.0, 0.1)
	player.scale.y = lerp(player.scale.y, 1.0, 0.1)
	player.global_position.x = lerp(player.global_position.x, target_player_pos.x, 0.2)
	player.global_position.y = lerp(player.global_position.y, target_player_pos.y, 0.2)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var clicked_cell = tilemap.local_to_map(tilemap.make_input_local(event).position)
			var player_cell = tilemap.local_to_map(player.global_position)
			if abs(clicked_cell.x - player_cell.x) < 2 and abs(clicked_cell.y - player_cell.y) < 2:
				if clicked_cell != player_cell:
					#player.global_position = tilemap.map_to_local(clicked_cell)
					target_player_pos = tilemap.map_to_local(clicked_cell)
					move_tile(tilemap.get_cell_source_id(1,clicked_cell,false),clicked_cell)
					player.scale = Vector2(1.2, 0.8)

func move_tile(tile,pos):
	match tile:
		2: #barn
			ui.food += 3
			tilemap.erase_cell(1,pos)
			ui.update_food()
			await ui.get_node("AnimationPlayer").animation_finished
		3: #blacksmith
			ui.population += 1
			ui.update_population()
			await ui.get_node("AnimationPlayer").animation_finished
		4: #mountain
			pass
		5: #plain
			pass
		6: #grass
			pass
	
	ui.points += ui.population
	ui.update_points()
	await ui.get_node("AnimationPlayer").animation_finished
	ui.food -= ui.population
	var kill = 0
	if ui.food < 0:
		kill = ui.food
		ui.food = 0
	ui.update_food()
	await ui.get_node("AnimationPlayer").animation_finished
	if kill < 0:
		ui.population += kill
		ui.update_population()
		await ui.get_node("AnimationPlayer").animation_finished
	if ui.population <= 0:
		print("game over")
