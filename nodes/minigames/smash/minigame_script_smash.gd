extends Node2D

const SPACING = 40.008

@onready var bucket = $Sprite2DBucket
@onready var player = $PlayerSceneSmash/CharacterBody2D
@onready var progress_icon = $ProgressIcon
@onready var meter_area = $MeterSceneSmash/MeterArea

@export var fruit_type = ""
@export var MAX_OBJECTIVE_COUNT = 10

var random = RandomNumberGenerator.new()

var smash_count = 0

func _ready():
	meter_area.connect("body_entered", _on_area_2d_body_entered)
	meter_area.connect("body_exited", _on_area_2d_body_exited)
	
	render_bucket_sprite()
	render_progress_icons()

func _process(delta):
	if Input.is_action_just_released("esc"):
		self.queue_free()

func _on_area_2d_body_entered(body):
	if(body.name == "ArrowBody"): player.can_jump = true
		
func _on_area_2d_body_exited(body):
	if(body.name == "ArrowBody"): player.can_jump = false

func handle_jump():
	if smash_count < MAX_OBJECTIVE_COUNT:
		smash_count += 1
		var progress_icon_copy = get_node("ProgressIcon{i}".format({"i": smash_count}))
		var sprite_path = "res://assets/placeholders/fruits/{type}_splat.png".format({"type": fruit_type})
		progress_icon_copy.set_texture(load(sprite_path))
		progress_icon_copy.scale.x = 1
		progress_icon_copy.scale.y = 1
		progress_icon_copy.rotation = random.randi_range(-180, 180)
	else: self.queue_free()

func render_bucket_sprite():
	var bucket_sprite = "res://assets/placeholders/fruits/{type}_bucket.png".format({"type": fruit_type})
	bucket.set_texture(load(bucket_sprite))

func render_progress_icons():
	progress_icon.visible = false
	var copy_position = progress_icon.position.x
	for i in range(1, MAX_OBJECTIVE_COUNT+1):
		var progress_icon_copy = progress_icon.duplicate()
		progress_icon_copy.position.x = copy_position
		copy_position += SPACING
		
		progress_icon_copy.name = "ProgressIcon{i}".format({"i": str(i)})
		
		var fruit_sprite = "res://assets/placeholders/fruits/{type}.png".format({"type": fruit_type})
		progress_icon_copy.set_texture(load(fruit_sprite))
		
		progress_icon_copy.visible = true
		add_child(progress_icon_copy)
