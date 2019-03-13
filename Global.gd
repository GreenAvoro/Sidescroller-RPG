extends Node

var current_Level = "Town"

var inventory = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func invent_add(item):
	inventory.append(item)
func invent_remove(item):
	for i in inventory:
		if i == item:
			inventory.remove(i)
			
