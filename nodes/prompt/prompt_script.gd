extends Node2D

@onready var panel = $PopupPanel
@onready var label = $PopupPanel/RichTextLabel

@export var text = ""

func _process(delta):
	label.text = text
	panel.visible = self.visible
