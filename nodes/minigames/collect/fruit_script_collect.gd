extends Node2D

@onready var area = $Area2D
@onready var sprite = $Area2D/Sprite2D

@export var speed = 200
@export var y_bound = 0
@export var type = ""

var velocity = Vector2.ZERO
const direction = Vector2(0,1)

func _ready():
	area.connect("body_entered", _on_area_2d_body_entered)
	var sprite_path = "res://assets/placeholders/fruits/{type}.png".format({"type": type})
	sprite.set_texture(load(sprite_path))
		

func _physics_process(delta):
	if not(get_node_or_null("../MinigameSceneSmash")):
		visible = true
		velocity.y = speed * direction.y
		position = position + velocity * delta
		
		if position.y > y_bound: self.queue_free()
	else: visible = false
	
func _on_area_2d_body_entered(body):
	if(body.name == "CharacterBody2DCollect"):
		get_parent()._on_collect(type)
		self.queue_free()
