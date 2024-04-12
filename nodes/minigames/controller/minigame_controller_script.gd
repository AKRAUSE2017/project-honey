extends Node2D

# children
@onready var area = $Area2D
@onready var prompt = $Prompt

@onready var player = $"../Player/CharacterBody2D"

func _ready():
	area.connect("body_entered", _on_area_2d_body_entered)
	area.connect("body_exited", _on_area_2d_body_exited)
	prompt.visible = false

func _process(delta):
	if prompt.visible:
		if Input.is_action_just_released("esc"): prompt.visible = false
		if Input.is_action_just_released("enter"):
			var minigame = preload("res://nodes/minigames/minigame_scene.tscn").instantiate()
			player.add_child(minigame)
			prompt.visible = false

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		prompt.text = "Start minigame?"
		prompt.visible = true
		
func _on_area_2d_body_exited(body):
	if (body.name == "CharacterBody2D"):
		prompt.visible = false
