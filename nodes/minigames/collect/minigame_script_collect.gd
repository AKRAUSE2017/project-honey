extends Node2D

@onready var background = $Background
@onready var player = $PlayerCollect/CharacterBody2DCollect
@onready var jam = $RecipeJam
@onready var progress_icon = $ProgressIcon

var game_width = 0
var game_height = 0

var fruit_path = "res://nodes/minigames/collect/fruit_scene_collect.tscn"
var smash_path = "res://nodes/minigames/smash/minigame_scene_smash.tscn"

var random = RandomNumberGenerator.new()

var timer = 0
var timer_thresh = 2

const fruit_types = ["grapes", "strawberry"]

var objective_fruit = ""
var objective_count = ""
var collected = 0

const MAX_OBJECTIVE_COUNT = 10
const SPACING = 40.008

func _ready():
	game_width = background.texture.get_width() * background.scale.x
	game_height = background.texture.get_height() * background.scale.y
	
	player.x1_bound = -game_width/2
	player.x2_bound = game_width/2
	
	set_game()

func _process(delta):
	if not(get_node_or_null("MinigameSceneSmash")):
		var timer_complete = timer_update(delta)
		if timer_complete:
			spawn_fruit()
			timer_reset()
		
		if Input.is_action_just_released("esc"):
			self.queue_free()
		
	if Input.is_action_just_released("enter"):
		open_smash_game()
		
func timer_update(delta):
	timer += delta
	return timer > timer_thresh

func timer_reset():
	timer = 0
	timer_thresh = 1

func spawn_fruit():
	var fruit = load(fruit_path).instantiate()
	var fruit_sprite = fruit.get_node("Area2D").get_node("Sprite2D")
	
	var fruit_width = fruit_sprite.texture.get_width() * fruit_sprite.scale.x
	fruit.position.x = random.randf_range((-game_width/2) + fruit_width/2, (game_width/2) - fruit_width/2)
	fruit.position.y = -game_height/2
	
	var fruit_height = fruit_sprite.texture.get_height() * fruit_sprite.scale.y
	fruit.y_bound = (game_height/2) - (fruit_height/2)
	
	fruit.type = fruit_types[random.randi_range(0, len(fruit_types)-1)]
	add_child(fruit)
	
func set_game():
	objective_fruit = fruit_types[random.randi_range(0, len(fruit_types)-1)]
	objective_count = 10
	collected = 0
	
	progress_icon.visible = false
	var copy_position = progress_icon.position.x
	for i in range(1, objective_count+1):
		var progress_icon_copy = progress_icon.duplicate()
		progress_icon_copy.name = "ProgressIcon{i}".format({"i": str(i)})
		progress_icon_copy.position.x = copy_position
		copy_position += SPACING
		
		var sprite_path = "res://assets/placeholders/fruits/{type}.png".format({"type": objective_fruit})
		progress_icon_copy.set_texture(load(sprite_path))
		
		sprite_path = "res://assets/placeholders/fruits/{type}_jam.png".format({"type": objective_fruit})
		jam.set_texture(load(sprite_path))
		
		if i <= objective_count: progress_icon_copy.visible = true
		else: progress_icon_copy.visible = false
		progress_icon_copy.modulate.a = 0.5
		
		progress_icon_copy.visible = true
		add_child(progress_icon_copy)

# triggered in fruit_script_collect
func _on_collect(type):
	if(type == objective_fruit):
		collected += 1
		var ghost = "ProgressIcon{i}".format({"i": str(collected)})
		var node = get_node(ghost)
		if(node):
			node.modulate.a = 1 # opacity
			
			if collected == objective_count: 
				open_smash_game()

func open_smash_game():
	var smash_game = load(smash_path).instantiate()
	smash_game.fruit_type = objective_fruit
	add_child(smash_game)
