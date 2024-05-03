extends Node2D

const ARROW_BODY_SPEED = 100

@onready var meter_area = $MeterArea
@onready var arrow_body = $ArrowBody
@onready var meter_sprite = $MeterArea/Sprite2D

var arrow_body_direction = Vector2(0,1)

var arrow_body_y1_bound
var arrow_body_y2_bound

func _ready():
	var meter_height = meter_sprite.texture.get_height() * meter_sprite.scale.y
	arrow_body_y1_bound = -meter_height/2
	arrow_body_y2_bound = meter_height/2

func _process(delta):
	set_direction()
	var velocity = ARROW_BODY_SPEED * arrow_body_direction
	arrow_body.position = arrow_body.position + velocity * delta

func set_direction():
	if arrow_body_direction.y == 1 and arrow_body.position.y >= arrow_body_y2_bound: 
		arrow_body_direction.y = -1
	elif arrow_body_direction.y == -1 and arrow_body.position.y <= arrow_body_y1_bound: 
		arrow_body_direction.y = 1
