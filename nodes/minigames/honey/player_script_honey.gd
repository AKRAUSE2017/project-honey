extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var bee = $Bee
signal dead_player

const SPEED = 300.0

var direction = Vector2.ZERO

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 3
var player_alive = true

func _ready():
	animation.play("idle_down")

func _physics_process(_delta):
	set_direction()
	set_animation()
	enemy_attack()
	
	if health <= 0:
		player_alive = false #Add end screen/game over
		health = 0
		print("player has been killed")
		dead_player.emit()
		self.queue_free()
		
	
	var speed = SPEED
	if not(direction.x == 0) and not(direction.y == 0): speed = speed * 0.75
	velocity.x = speed * direction.x
	velocity.y = speed * direction.y
	
	if not(get_node_or_null("MiniGame")): # if minigame is not a child of the character (i.e. minigame is not open)
		move_and_slide()

func set_direction():
	direction.x = int(Input.is_action_pressed("right")) -  int(Input.is_action_pressed(("left")))
	direction.y = int(Input.is_action_pressed("down")) -  int(Input.is_action_pressed(("up")))

func set_animation():
	if not(get_node_or_null("MiniGame")): # if minigame is not a child of the character (i.e. minigame is not open)
		if direction.x == 1: animation.play("walk_right")
		elif direction.x == -1: animation.play("walk_left")
		elif direction.y == 1: animation.play("walk_down")
		elif direction.y == -1: animation.play("walk_up")
		else: idle_animation()

func idle_animation():
	if Input.is_action_just_released("right"): animation.play("idle_right")
	elif Input.is_action_just_released("left"): animation.play("idle_left")
	elif Input.is_action_just_released("up"): animation.play("idle_up")
	elif Input.is_action_just_released("down"): animation.play("idle_down")

func player():
	pass

func _on_player_honey_hit_box_body_entered(body):
	if body.has_method("Bee"):
		enemy_in_attack_range = true

func _on_player_honey_hit_box_body_exited(body):
		if body.has_method("Bee"):
			enemy_in_attack_range = false
			
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 1
		enemy_attack_cooldown = false 
		$Attack_Cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	

