extends Area2D

var state = "idle"
var dir = "right"
var dmg = 50
var enemies_hit = []
var knockback_force = 300

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if state == "attack":
		for body in get_overlapping_bodies():
			if body.is_in_group("enemies") and not body in enemies_hit:
				if dir == "right":
					body.knockback = knockback_force
				else:
					body.knockback = -knockback_force
				body.knockback_jump = true
				body.hp -= dmg
				enemies_hit.append(body)
	
	
func norm_attack():
	if dir == "right":
		$AnimationPlayer.play("attack_right")
	else:
		$AnimationPlayer.play("attack_left")
	state = "attack"
	
func up_attack():
	if dir == "right":
		$AnimationPlayer.play("attack_up_right")
	else:
		$AnimationPlayer.play("attack_up_left")
		
	state = "attack"
	
func down_attack():
	if dir == "right":
		$AnimationPlayer.play("attack_right")
	else:
		$AnimationPlayer.play("attack_left")
	state = "attack"

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack_right" or anim_name == "attack_left" or anim_name == "attack_up_right" or anim_name == "attack_up_left":
		state = "idle"
		enemies_hit = []
