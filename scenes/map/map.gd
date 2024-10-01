extends Node2D

@onready var tilemap = $TileMap
@onready var player = $Player
@onready var ui = $MainUI

var target_player_pos
var over_flag := false

@export var slot1 := 0
@export var slot2 := 0

func _ready():
	Audio.get_node("Gameplay").play()
	$Player.get_node("Sprite2D").play()
	randomize()
	$GameOver.hide()
	$Deck.hide()
	for x in range(-3,7):
		for y in range(-1,4):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x,y),tile,Vector2i(0,0))
			if x!= 2 and y!=1:
				spawn_item(x,y)
	
	player.global_position = tilemap.map_to_local(Vector2(2,1))
	target_player_pos = player.global_position

func spawn_item(x,y):
	var pick = randi_range(1,2)
	if pick == 1:
		var item = Rng.get_event_rarity()
		match item:
			"stone":
				tilemap.set_cell(1,Vector2i(x,y),7,Vector2i(0,1))
			"lemur":
				tilemap.set_cell(1,Vector2i(x,y),6,Vector2i(0,0))
			"food":
				tilemap.set_cell(1,Vector2i(x,y),[3,4,5].pick_random(),Vector2i(0,0))
			"mystery":
				tilemap.set_cell(1,Vector2i(x,y),8,Vector2i(0,0))
			"minus":
				tilemap.set_cell(1,Vector2i(x,y),9,Vector2i(0,0))
			"plus":
				tilemap.set_cell(1,Vector2i(x,y),10,Vector2i(0,0))
			"fire":
				tilemap.set_cell(1,Vector2i(x,y),12,Vector2i(0,0))

func _physics_process(_delta):
	var mouse = get_global_mouse_position()
	if mouse.x > player.global_position.x:
		player.get_node("Sprite2D").flip_h = false
	else:
		player.get_node("Sprite2D").flip_h = true
	player.scale.x = lerp(player.scale.x, 1.0, 0.1)
	player.scale.y = lerp(player.scale.y, 1.0, 0.1)
	player.global_position.x = lerp(player.global_position.x, target_player_pos.x, 0.2)
	player.global_position.y = lerp(player.global_position.y, target_player_pos.y, 0.2)

func _unhandled_input(event):
	var clicked_cell = tilemap.local_to_map(get_global_mouse_position())
	var player_cell = tilemap.local_to_map(player.global_position)
	if over_flag:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if clicked_cell in tilemap.get_surrounding_cells(player_cell):
				if clicked_cell != player_cell:
					if tilemap.get_cell_source_id(1,clicked_cell) != 7:
						target_player_pos = tilemap.map_to_local(clicked_cell)
						generate(clicked_cell)
						player.scale = Vector2(1.2, 0.8)
						move_tile(tilemap.get_cell_source_id(1,clicked_cell,false),clicked_cell)
	$SelectLight.global_position = tilemap.map_to_local(clicked_cell)
	if clicked_cell in tilemap.get_surrounding_cells(player_cell):
		if clicked_cell != player_cell:
			if tilemap.get_cell_source_id(1,clicked_cell) != 7:
				$SelectLight.show()
			else:
				$SelectLight.hide()
		else:
			$SelectLight.hide()
	else:
		$SelectLight.hide()

func generate(cell):
	var x = cell.x
	var y = cell.y
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x+i,y-2)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x+i,y-2),tile,Vector2i(0,0))
			spawn_item(x+i,y-2)
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x+i,y+2)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x+i,y+2),tile,Vector2i(0,0))
			spawn_item(x+i,y+2)
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x+3,y+i)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x+3,y+i),tile,Vector2i(0,0))
			spawn_item(x+3,y+i)
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x+4,y+i)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x+4,y+i),tile,Vector2i(0,0))
			spawn_item(x+4,y+i)
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x-4,y+i)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x-4,y+i),tile,Vector2i(0,0))
			spawn_item(x-4,y+i)
	
	for i in range(-3,4):
		if not tilemap.get_cell_tile_data(0,Vector2i(x-5,y+i)):
			var tile = Rng.get_rarity()
			tilemap.set_cell(0,Vector2i(x-5,y+i),tile,Vector2i(0,0))
			spawn_item(x-5,y+i)

func move_tile(tile,pos):
	if over_flag:
		return
	Audio.get_node("Jump").play()
	
	match tile:
		0:
			pass
		1:
			pass
		2:
			pass
		3:
			ui.food += 3
			if slot1 == 1:
				ui.food += 2
			if slot2 == 1:
				ui.food += 2
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.update_food()
			await ui.get_node("AnimationPlayer").animation_finished
		4:
			ui.food += 3
			if slot1 == 1:
				ui.food += 2
			if slot2 == 1:
				ui.food += 2
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.update_food()
			await ui.get_node("AnimationPlayer").animation_finished
		5:
			ui.food += 3
			if slot1 == 1:
				ui.food += 2
			if slot2 == 1:
				ui.food += 2
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.update_food()
			await ui.get_node("AnimationPlayer").animation_finished
		6:
			ui.population += 1
			if slot1 == 3:
				ui.population += 1
			if slot2 == 3:
				ui.population += 1
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.update_population()
			await ui.get_node("AnimationPlayer").animation_finished
		7:
			pass
		8:
			$Deck.get_card()
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
		9:
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.points -= 5 * ui.population
			ui.update_points()
			await ui.get_node("AnimationPlayer").animation_finished
		10:
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.points += 2 * ui.population
			ui.update_points()
			await ui.get_node("AnimationPlayer").animation_finished
		12:
			ui.population -= 3
			if slot1 == 4:
				ui.population += 1
			if slot2 == 4:
				ui.population += 1
			var blob = tilemap.get_cell_source_id(0,pos,false)
			tilemap.set_cell(1,pos,blob,Vector2i(0,0))
			ui.update_population()
			await ui.get_node("AnimationPlayer").animation_finished
	
	var neg = tilemap.get_used_cells_by_id(1,9)
	for celln in neg:
		tilemap.set_cell(1,celln,11,Vector2i(0,0))
	
	var posi = tilemap.get_used_cells_by_id(1,10)
	for cellp in posi:
		tilemap.set_cell(1,cellp,9,Vector2i(0,0))
	
	var tem = tilemap.get_used_cells_by_id(1,11)
	for celln in neg:
		tilemap.set_cell(1,celln,10,Vector2i(0,0))
	
	ui.points += ui.population
	ui.update_points()
	await ui.get_node("AnimationPlayer").animation_finished
	ui.food -= ui.population / 2 +1
	if slot1 == 4:
		ui.food += ui.population /4
	if slot2 == 4:
		ui.food += ui.population /4
	var kill = 0
	if ui.food < 0:
		kill = ui.food
		ui.food = 0
	ui.update_food()
	
	var temp_food = ui.food
	temp_food -= ui.population / 2 +1
	if slot1 == 4:
		temp_food += ui.population /4
	if slot2 == 4:
		temp_food += ui.population /4
	if temp_food <=0:
		$MainUI.warning(true)
	else:
		$MainUI.warning(false)
	
	await ui.get_node("AnimationPlayer").animation_finished
	if kill < 0:
		ui.population += kill
		if slot1 == 4:
			ui.population += abs(kill)/3
		if slot2 == 4:
			ui.population += abs(kill)/3
		ui.update_population()
		await ui.get_node("AnimationPlayer").animation_finished
	if ui.population <= 0:
		if slot1 == 7:
			Audio.get_node("LoseCard").play()
			slot1 = 0
			$MainUI/Control/Card1.texture = null
			return
		if slot2 == 7:
			Audio.get_node("LoseCard").play()
			slot2 = 0
			$MainUI/Control/Card2.texture = null
			return
		if not over_flag:
			game_over()

func game_over():
	over_flag = true
	Global.points = ui.points
	$GameOver.game_over()
