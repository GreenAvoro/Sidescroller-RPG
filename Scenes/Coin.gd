extends Area2D



func _ready():
	$AnimationPlayer.advance(randf()*1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Coin_body_entered(body):
	if body.name == "Player":
		queue_free()
