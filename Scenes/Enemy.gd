extends KinematicBody2D

signal dead

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 50
const JUMP_HEIGHT = -370
const KNOCKBACK_JUMP = -200
var motion = Vector2()
var chase = false
var facing = "right"
export(int) var hp = 100
export(Texture) var Enemy_Sprite = null
var jump = false
var knockback = 0
var knockback_jump = false

#Try jump again timer
var try_jump = 0
var try_jump_period = 1
var old_x = 0


var behaviour_timer = 0
var behaviour_period = 2
var walk_time = 0
var walk_dir = 0

func _ready():
	$Sprite.texture = Enemy_Sprite


func _process(delta):
	if hp <= 0:
		emit_signal("dead")
		queue_free()

func _physics_process(delta):
	#Gravity
	motion.y += GRAVITY
	
	#Decide if there should be a random walk behaviour
	if behaviour_timer > behaviour_period:
		if randi()%2 == 1:
			walk_dir = randi()%2 #random int between 0 - 1
			walk_time = randf()*2.0 + 0.5
		behaviour_timer = 0
	else:
		behaviour_timer += delta
			 
	
	#do a mini jump along with knockback
	if knockback_jump:
		motion.y = KNOCKBACK_JUMP
		knockback_jump = false
		
	if knockback > 4.0 or knockback < -4.0:
		motion.x = knockback
		knockback = lerp(knockback, 0.0,10.0*delta)

	
	elif chase: 
		var p_pos = get_node("/root/"+ Global.current_Level + "/Player").position
		if p_pos.x < position.x:
			motion.x = -SPEED
			$JumpDetect.position.x = -10

		else:
			motion.x = SPEED
			$JumpDetect.position.x = 10
		
		
		#Detect if enemy hasn't moved in the last second; if so, jump
		if position.x == old_x:
			if try_jump > try_jump_period:
				jump = true
				try_jump = 0
			else:
				try_jump += delta
				
	elif walk_time > 0:
		if walk_dir == 0:
			motion.x = -SPEED
		else:
			motion.x = SPEED
		walk_time -= delta
	else:
		motion.x = 0
	#To stop chasing the player
	#else:
		#motion.x = 0
	if not is_on_floor():
		jump = false
	if jump:
		motion.y = JUMP_HEIGHT
		jump = false
	

	old_x = position.x
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
		jump = true
