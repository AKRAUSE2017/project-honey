extends CharacterBody2D

@export var x1_bound = 0
@export var x2_bound = 0

@onready var animation = $AnimatedSprite2D

const SPEED = 150

var direction = Vector2.ZERO
var sprite_width = 0
var sprite_height = 0

func _ready():
	animation.play("idle_down")
	
	var dims = animation.sprite_frames.get_frame_texture("idle_down", 0).get_size()
	sprite_width = dims[0]
	sprite_height = dims[1]

func _physics_process(_delta):
	print(position.x)
	if not(get_node_or_null("../../MinigameSceneSmash")):
		visible = true
		set_direction()
		set_animation()
		
		velocity = SPEED * direction
		if can_move(): move_and_slide()
	else: 
		visible = false
		idle_animation()

func set_direction():
	direction.x = int(Input.is_action_pressed("right")) -  int(Input.is_action_pressed(("left")))

func set_animation():
	if direction.x == 1: animation.play("walk_right")
	elif direction.x == -1: animation.play("walk_left")
	else: idle_animation()

func can_move():
	var cond1 = position.x > (x1_bound + sprite_width/2) and position.x < (x2_bound - sprite_width/2)
	var cond2 = position.x < (x1_bound + sprite_width/2) and direction.x == 1
	var cond3 = position.x > (x2_bound - sprite_width/2) and direction.x == -1
	return cond1 or cond2 or cond3

func idle_animation():
	if Input.is_action_just_released("right"): animation.play("idle_right")
	elif Input.is_action_just_released("left"): animation.play("idle_left")
	
