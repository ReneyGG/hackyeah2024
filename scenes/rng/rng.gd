extends Node

var rarities = {
	0 : 30, #plains
	1 : 30, #plains 2
	2 : 30, #plains 3
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
	
