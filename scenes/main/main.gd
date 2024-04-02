extends Node2D

@onready var player_scene = preload("res://scenes/player/player_scene.tscn").instantiate()

func _ready():
	player_scene.position = Vector2.ZERO
	add_child(player_scene)
