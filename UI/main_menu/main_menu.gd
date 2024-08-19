extends Control

var level1 = preload("res://Levels/vert_slice.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_full
	get_tree().change_scene_to_packed(level1)
