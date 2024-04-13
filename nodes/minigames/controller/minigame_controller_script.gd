extends Node2D

@export var minigame_id = ""
@export var custom_prompt = ""

# children
@onready var area = $Area2D
@onready var prompt = $Prompt

@onready var player = $"../Player/CharacterBody2D"

func _ready():
	area.connect("body_entered", _on_area_2d_body_entered)
	area.connect("body_exited", _on_area_2d_body_exited)
	prompt.visible = false

func _process(_delta):
	if prompt.visible:
		if Input.is_action_just_released("esc"): prompt.visible = false
		if Input.is_action_just_released("enter"):
			var minigame_path = "res://nodes/minigames/{id}/minigame_scene_{id}.tscn".format({"id": minigame_id})
			var minigame = load(minigame_path).instantiate()
			player.add_child(minigame)
			prompt.visible = false

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if custom_prompt == "": prompt.text = "Start {id} minigame?".format({"id": minigame_id})
		else: prompt.text = custom_prompt
		prompt.visible = true
		
func _on_area_2d_body_exited(body):
	if (body.name == "CharacterBody2D"):
		prompt.visible = false
