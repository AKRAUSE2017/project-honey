extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var bee = $Bee

@export var inv: Inv #importing the inventory so you can attach an inventory to the character

@export var x1_bound = 0
@export var x2_bound = 0
@export var y1_bound = 0
@export var y2_bound = 0
signal dead_player

const SPEED = 300.0

var direction = Vector2.ZERO

var honey_reached = false
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 3
var player_alive = true
var sprite_width = 0
var sprite_height = 0

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
	
	if can_move_x() and can_move_y() and not honey_reached: move_and_slide()

func set_direction():
	direction.x = int(Input.is_action_pressed("right")) -  int(Input.is_action_pressed(("left")))
	direction.y = int(Input.is_action_pressed("down")) -  int(Input.is_action_pressed(("up")))

func set_animation():
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

func can_move_x():
	var cond1 = position.x > (x1_bound) and position.x < (x2_bound)
	var cond2 = position.x < (x1_bound) and direction.x == 1
	var cond3 = position.x > (x2_bound) and direction.x == -1

	return cond1 or cond2 or cond3 

func can_move_y():
	var cond4 = position.y > (y1_bound) and position.y < (y2_bound)
	var cond5 = position.y < (y1_bound) and direction.y == 1
	var cond6 = position.y > (y2_bound) and direction.y == -1
	
	return cond4 or cond5 or cond6
	
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
		animation.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		animation.modulate = Color.WHITE

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func _on_area_2d_body_entered(body):
	honey_reached = true
	
func collect(item): #sends items to player's inventory
	inv.insert(item)
