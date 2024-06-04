extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var player = get_node("/root/Main/Player/CharacterBody2D/MiniGame/Player_Honey/PlayerCharacterBody2D")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var dir = Vector2.ZERO
var acceleration = 7
const SPEED = 150
 
var attacking = false

func _physics_process(delta):
	bee_aniamtion()
	
	dir = nav_agent.get_next_path_position() - global_position
	dir = round(dir.normalized())
	
	var speed = SPEED
	velocity = velocity.lerp(dir * speed, acceleration * delta)
	move_and_slide()

func _on_timer_timeout():
	if player != null:
		nav_agent.target_position = player.global_position
	
func Bee():
	pass

func _on_bee_hitbox_body_entered(body):
	if body.has_method("player"):
		attacking = true
	else: attacking = false

func bee_aniamtion():
	if attacking == false:
		if dir.x == 1: animation.play("walk_right")
		elif dir.x == -1: animation.play("walk_left")
		elif dir.y == 1: animation.play("walk_down")
		elif dir.y == -1: animation.play("walk_up")
	else: 
		if dir.x == 1: animation.play("attack_right")
		elif dir.x == -1: animation.play("attack_left")
		elif dir.y == 1: animation.play("attack_down")
		elif dir.y == -1: animation.play("attack_up")
