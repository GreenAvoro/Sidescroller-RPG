extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()

#3 hp : 3 hits and you deed.
var health = 3

func _ready():
	pass
func _process(delta):
	pass

func _physics_process(delta):
	#Gravity
	motion.y += GRAVITY
	
	if Input.is_action_just_pressed("ui_select"):
		if $Weapon.state == "idle":
			if is_on_floor():
				$Weapon.norm_attack()
			elif motion.y < 0:
				$Weapon.up_attack()
			elif motion.y > 0 and not is_on_floor():
				motion.y += 600
				$Weapon.down_attack()
	
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		$Weapon.dir = "right"
		$Weapon/Sprite.flip_h = false
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Weapon.dir = "left"
		$Weapon/Sprite.flip_h = true
		
	else:
		motion.x = 0
		
	
	if is_on_floor():	
		if Input.is_action_just_pressed("ui_up"):
			 motion.y = JUMP_HEIGHT
	else:
		pass
	
		
	motion = move_and_slide(motion,UP)


func _on_Boss_dead():
	pass
	#Global.current_Level = "Level2"
	#get_tree().change_scene("res://Scenes/Level2.tscn")


#Rework so that it is enemy attacks that damage, not collision
func _on_Hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		health -= 1
		print("Current hp: " + str(health))
		
