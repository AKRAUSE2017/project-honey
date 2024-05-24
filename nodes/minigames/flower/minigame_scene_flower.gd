extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	for n in 5:
		var flower = preload("res://nodes/minigames/flower/flower.tscn").instantiate()
		flower.position.x = randi_range(-400, 400);
		flower.position.y = randi_range(-200, 200);
		add_child(flower)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
