extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const SPEED = 150.0
const ACCELERATION = 500
const FRICTION = 500

var direction = Vector2.ZERO

func _ready():
	position.x = 600
	position.y = 300
	animation.play("idle_down")

func _physics_process(delta):
	set_direction()
	set_animation()
	
	var norm_direction = (direction).normalized()
	if(norm_direction != Vector2.ZERO):
		velocity = velocity.move_toward(norm_direction*SPEED, ACCELERATION * delta)
	else: velocity = velocity.move_toward(norm_direction*SPEED, FRICTION * delta)
	
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
