extends Node2D
class_name Friend

enum FRIEND_TYPES {ADDING, MULTIPLYING}
@onready var sprite_2d: Sprite2D = $Sprite2D

var friend_type : FRIEND_TYPES
var sprite 


func _ready() -> void:
	sprite_2d.texture = sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
