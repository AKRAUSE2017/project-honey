extends Node2D

@onready var label = $CanvasLayer/RichTextLabel

@export var text = ""

func _process(_delta):
	label.text = text
	label.visible = self.visible
