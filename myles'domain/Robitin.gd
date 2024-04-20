extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 110
@export var FRICTION = 500

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animationState = animation_tree.get("parameters/playback")
#var velocity = Vector2.ZERO



func _ready():
	pass

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
			animation_tree.set("parameters/Idle/blend_position", input_vector)
			animation_tree.set("parameters/Walk/blend_position", input_vector)
			animationState.travel("Walk")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	@warning_ignore("int_as_enum_without_cast")
	motion_mode = 1
	move_and_slide()
