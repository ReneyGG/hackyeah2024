extends Node

var rarities = {
	0 : 50, #plains
	1 : 50, #plains 2
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
	
