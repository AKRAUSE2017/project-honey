extends Node2D

@onready var background = $Sprite2D
@onready var player_honey = $Player_Honey/PlayerCharacterBody2D
@onready var prompt = $PopupPanel

@export var custom_prompt = ""
@export var item: InvItem #allows the InvItem resource to be used

var game_width = 0
var game_height = 0
var player_in_area = false

func _ready():
	prompt.visible = false
	
	game_width = background.texture.get_width() * background.scale.x
	game_height = background.texture.get_height() * background.scale.y
	print(background.texture.get_width())
	print(background.scale.x)
	print("Game width: ",game_width)
	player_honey.x1_bound = (-game_width/2)+25
	player_honey.x2_bound = (game_width/2)-25
	print(player_honey.x1_bound,", ", player_honey.x2_bound)
	
	player_honey.y1_bound = -game_height/2
	player_honey.y2_bound = (game_height/2)-40
	print(background.texture.get_height())
	print(background.scale.y)
	print("Game height: ",game_height)
	print(player_honey.y1_bound,", ", player_honey.y2_bound)
	
func _process(_delta):
	if Input.is_action_just_released("esc"):
		self.queue_free()
		
func _on_player_character_body_2d_dead_player():
	if custom_prompt == "": prompt.text = "[center]You died :([/center]"
	else: prompt.text = custom_prompt
	prompt.visible = true
 
func _on_area_2d_body_entered(body):
	if custom_prompt == "": prompt.text = "[center]You made it to the honey[/center]"
	else: prompt.text = custom_prompt
	prompt.visible = true
	player_honey.collect(item) #passes the honey object to the player's inventory when collected

