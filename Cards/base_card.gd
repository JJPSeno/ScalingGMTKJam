extends Button
class_name Card

@export_group("Internals")
@export var name_label: Label
@export var friend_sprite: TextureRect
@export var description_label: Label
@export var cost_label: Label

var card_name
var sprite
var description
var cost
var card_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    name_label.text = card_name
    friend_sprite.texture = sprite
    description_label.text = description
    cost_label.text = cost
    name = str(card_name, " - ", randf())

func _on_pressed() -> void:
    GameManager.emit_signal("set_up_card",card_type)
    queue_free()


func _on_mouse_entered() -> void:
    self.scale = Vector2(1.02, 1.02)


func _on_mouse_exited() -> void:
    self.scale = Vector2(1.0, 1.0)
