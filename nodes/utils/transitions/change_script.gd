extends Node2D

@export var scene_path:String
@export var onTop:bool

@onready var area = $Area2D
@onready var animation = $CanvasLayer/AnimationPlayer

var start_position: Vector2

func _ready():
	animation.play_backwards('dissolve')
	area.connect("body_entered", _on_area_2d_body_entered)

func transition_scene():
	animation.play('dissolve')
	await animation.animation_finished
	var new_scene = load(scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	var new_player = new_scene.get_node("Player/CharacterBody2D")
	var new_scene_transition_spot = new_scene.get_node("SceneTransition")
	var offset = -80
	var direction = "idle_up"
	if (new_scene_transition_spot.onTop): 
		offset = 80
		direction = "idle_down"
	new_player.get_node("AnimatedSprite2D").play(direction)
	new_player.position.x = start_position.x
	new_player.position.y = new_scene_transition_spot.position.y + offset
	print(new_scene_transition_spot.position.y)
	
	var main = get_node("../")
	main.queue_free()

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if(scene_path): 
			start_position = body.position
			transition_scene()
