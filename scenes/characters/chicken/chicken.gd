extends NonPlayableCharacter

func _ready():
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)