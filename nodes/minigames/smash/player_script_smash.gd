extends CharacterBody2D

const JUMP_HEIGHT = 120.0
const GRAVITY = 5.0

@export var can_jump = false # controlled by parent scene script
@export var state = "idle_down"

@onready var animation = $AnimatedSprite2D
@onready var parent_scene = get_parent().get_parent()

var direction = Vector2.ZERO
var start_position = Vector2.ZERO

func _ready():
	animation.connect("animation_finished", _on_animation_finished)
	start_position.y = position.y

func _physics_process(delta):
	check_and_set_jump()
	if state == "jump":
		velocity.y = velocity.y + GRAVITY
		position.y = position.y + velocity.y * delta
		if position.y > start_position.y:
			position.y = start_position.y
			state = "idle_down"
	
	animation.play(state)

func _on_animation_finished():
	if state == "jump": state = "idle_down"
	position.y = start_position.y
	
func check_and_set_jump():
	if Input.is_action_just_pressed("space") and not(state == "jump") and can_jump:
		animation.play("jump")
		state = "jump"
		velocity.y = -JUMP_HEIGHT
		
		parent_scene.handle_jump()
