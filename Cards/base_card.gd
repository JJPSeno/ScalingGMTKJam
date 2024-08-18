extends Button
class_name Card

@onready var name_label: Label = $CardContainer/MarginContainer/VBoxContainer/NameLabel
@onready var friend_sprite: TextureRect = $CardContainer/MarginContainer/VBoxContainer/FriendSprite
@onready var description_label: Label = $CardContainer/MarginContainer/VBoxContainer/DescriptionLabel
@onready var cost_label: Label = $Panel/CostLabel

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_pressed() -> void:
    GameManager.emit_signal("set_up_card",card_type)
    queue_free()


func _on_mouse_entered() -> void:
    self.scale = Vector2(1.02, 1.02)


func _on_mouse_exited() -> void:
    self.scale = Vector2(1.0, 1.0)
