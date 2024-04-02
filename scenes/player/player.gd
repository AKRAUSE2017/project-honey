extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const SPEED = 300.0

var direction = Vector2.ZERO

func _ready():
	animation.play("idle_down")

func _physics_process(delta):
	set_direction()
	set_animation()
	
	var speed = SPEED
	if not(direction.x == 0) and not(direction.y == 0): speed = speed * 0.75
	velocity.x = speed * direction.x
	velocity.y = speed * direction.y
	
	move_and_slide()

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
