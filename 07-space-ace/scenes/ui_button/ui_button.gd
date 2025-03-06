class_name UIButon extends TextureButton


@export var button_text: String = "Set Me"


@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_label_text(button_text)


func _set_label_text(text: String) -> void:
	label.text = text
