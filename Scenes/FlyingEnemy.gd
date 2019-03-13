extends KinematicBody2D

signal dead

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 10
const KNOCKBACK_JUMP = -200
var motion = Vector2()
var chase = false
var facing = "right"
export(int) var hp = 100
export(Texture) var Enemy_Sprite = null
var knockback = 0
var knockback_jump = false


func _ready():
	$Sprite.texture = Enemy_Sprite


func _process(delta):
	if hp <= 0:
		emit_signal("dead")
		queue_free()

func _physics_process(delta):
	#Gravity

	
	#do a mini jump along with knockback
	if knockback_jump:
		motion.y = KNOCKBACK_JUMP
		knockback_jump = false
		
	if knockback > 4.0 or knockback < -4.0:
		motion.x = knockback
		knockback = lerp(knockback, 0.0,10.0*delta)

	
	
	elif chase: 
		var p_pos = get_node("/root/"+ Global.current_Level + "/Player").position
		motion = (p_pos - position)* SPEED * delta
		
		

			
	#To stop chasing the player
	#else:
	

	motion = move_and_slide(motion,UP)
	pass



func _on_Detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_Detection_body_exited(body):
	if body.name == "Player":
		pass
		#chase = false




func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		pass

