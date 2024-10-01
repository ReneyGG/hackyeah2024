extends Node

var rarities = {
	0 : 30, #plains
	1 : 30, #plains 2
	2 : 30, #plains 3
}

var events_rarities = {
	"stone" : 35,
	"lemur" : 25,
	"food" : 25,
	"fire" : 15,
	"minus" : 10,
	"plus" : 10,
	"mystery" : 5,
}

var rng = RandomNumberGenerator.new()

func get_rarity():
	rng.randomize()
	
	var weighted_sum = 0
	
	for n in rarities:
		weighted_sum += rarities[n]
	
	var item = rng.randi_range(0, weighted_sum)
	
	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n]

func get_event_rarity():
	rng.randomize()
	
	var weighted_sum = 0
	
	for n in events_rarities:
		weighted_sum += events_rarities[n]
	
	var item = rng.randi_range(0, weighted_sum)
	
	for n in events_rarities:
		if item <= events_rarities[n]:
			return n
		item -= events_rarities[n]
