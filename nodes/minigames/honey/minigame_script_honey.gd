extends Node2D

func _process(_delta):
	if Input.is_action_just_released("esc"):
		self.queue_free()