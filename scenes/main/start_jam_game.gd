extends Area2D

func _ready():
	self.body_entered.connect(self._on_body_entered)

func _on_body_entered(other):
	print("body entered", other)
	open_prompt()

func open_prompt():
	var prompt = preload("res://scenes/minigames/prompt/prompt_scene.tscn").instantiate()
	prompt.text = "Would you like to start making jam?"
	prompt.is_visible = true
	add_child(prompt)
