extends Node

var rarities = {
	5 : 40, #plains
	6 : 35, #grass
	4 : 15, #mountains
	2 : 5, #barn
	3 : 5, #blacksmith
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
	
