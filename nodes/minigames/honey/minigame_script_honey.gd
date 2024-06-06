extends Node2D

@onready var player = $"../Player/CharacterBody2D"
@onready var player_honey = $Player_Honey
@onready var panel = $Panel

func _ready():
	panel.visible = false

func _process(_delta):
	if Input.is_action_just_released("esc"):
		self.queue_free()
		
func _on_player_character_body_2d_dead_player():
	panel.visible = true
