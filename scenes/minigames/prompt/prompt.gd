extends Node2D
@export var text = "test"
@export var is_visible = false

@onready var panel = $PopupPanel
@onready var label = panel.get_child(0) 

func _process(delta):
	label.text = text
	
	if is_visible and Input.is_action_just_released("esc"):
		is_visible = false
	
	if is_visible and Input.is_action_just_released("enter"):
		var popup_scene = preload("res://scenes/minigames/popup_scene.tscn").instantiate()
		add_child(popup_scene)
		popup_scene.global_position = Vector2.ZERO
		
		is_visible = false
		panel.visible = false
