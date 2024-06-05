extends PopupPanel

@onready var popup_panel = $"."
@onready var rich_text_label = $RichTextLabel

@export var text = ""

func _process(_delta):
	rich_text_label.text = text
	popup_panel.visible = self.visible
