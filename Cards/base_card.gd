extends Control
class_name Card

@export_group("Internals")
@export var card_size := Vector2(200,300)
@export var transformee:Control
@export var name_label: Label
@export var friend_sprite: TextureRect
@export var description_label: Label
@export var cost_label: Label

var card_name
var sprite
var description
var cost
var card_type

@onready var target_container_size:Vector2 = custom_minimum_size
@onready var target_scale:Vector2 = transformee.scale


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    name_label.text = card_name
    friend_sprite.texture = sprite
    description_label.text = description
    cost_label.text = cost
    name = str(card_name, " - ", randf())
    
func _process(delta: float) -> void:
    """
    Animating the following:
        1. Expand Base Card Container
        2. Scale Up Transform container
        
    These values were chosen by hand cause they looked nice
    """
    var tgt_size = custom_minimum_size\
        .move_toward(target_container_size, 5)
    var tgt_scale = transformee.scale\
        .move_toward(target_scale, 0.02)
    
    custom_minimum_size = tgt_size
    transformee.scale = tgt_scale
func _on_pressed() -> void:
    GameManager.emit_signal("set_up_card",card_type)
    queue_free()

func _on_mouse_entered() -> void:
    var new_size = card_size * Vector2(1.25,1)
    var new_scale = transformee.scale * Vector2(1.15,1.15)
    target_container_size = new_size
    target_scale = new_scale


func _on_mouse_exited() -> void:
    target_container_size = card_size
    target_scale = Vector2.ONE
