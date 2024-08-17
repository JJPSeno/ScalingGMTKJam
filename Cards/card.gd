extends Button

@onready var texture_rect: TextureRect = $CardContainer/MarginContainer/VBoxContainer/TextureRect
var sprite = preload("res://icon.svg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
