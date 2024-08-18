extends Node2D
class_name Friend

enum FRIEND_TYPES {ADDING, MULTIPLYING, ADDING2, EXPO}
@onready var sprite_2d: Sprite2D = $Sprite2D

var friend_type : FRIEND_TYPES
var sprite:Texture2D


func _ready() -> void:
	sprite_2d.texture = sprite
	
func _process(delta: float) -> void:
	var size = sprite_2d.texture.get_size() 
	sprite_2d.position = Vector2(0, -size.y)
